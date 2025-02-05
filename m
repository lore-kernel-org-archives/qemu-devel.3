Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42E14C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 22:02:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfnTw-0002EQ-9p; Wed, 05 Feb 2025 17:02:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tfnTk-00026b-Gu
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 17:02:46 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tfnTh-0006wF-Ma
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 17:02:40 -0500
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 515Gfnvp028367;
 Wed, 5 Feb 2025 22:02:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=gZvwF8h2OXok5xId7ix5VfXM+1lJOnLjJASbDUngPYA=; b=
 iU6zYvCRkF12TBlrBKUAh8z0P9dBBwFziHbC1kzobguj5BZ/pBpJIWbPE+yu8Q4A
 KmP1FrDzbk0J19S+FIBkqKg8XVHUZ4jv/YsP+FjMq1n+EdPeb7Xmor0uhLn8cSzn
 SznA/XTKGoFfpAnHyOZJ9Jv8sohhwDtq5KxZHO9nKf9SF0kKOOrpfrleX6oO0Kn9
 nbdOnRiO6u2OsTFETCxLziKMiGFEaSa20DN4zYsSK0MALQYGby9FinAZcxYwprdB
 4SJtZRLZTUH20Zy5FbJTENB1QZuWsYlXI3H38sYOfhlQq60j02XIFbQSysiskdy1
 7b5O13n7qoQyE7OyZkFSDQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hfch0b9d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2025 22:02:34 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 515Ln1eM026995; Wed, 5 Feb 2025 22:02:34 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com
 (mail-dm3nam02lp2049.outbound.protection.outlook.com [104.47.56.49])
 by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 44j8fp63e3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 05 Feb 2025 22:02:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wIf015kVIgfj91Cp5aLS7xS8SzLdHPKqp7XJ7xPxKYEpRSU9+lY+6DFeMtASkFfUXB9XcabFI2ATxM3/gsE9sMGBBBIbGilAP5STfcpR8yrV7voHcXwgGwxYUPrShmx8HysMYGqKwSDd//jJt7F0hpBqAf1bOxj3Kt60kuiTBpnOarg0vMZBysetJFqFBhYG3U17ZKQCnPxybAxGtrjoKihvREhpNVnJ3OFne9SZ/FgKj3ajV26IOGkunPWei78WDZewrgFAEPJLD+8w+tkoYngBvHyPC2NVgjAPuk9EgNxBVY04h986po9KRZv8cMMkcSkPer08PXWv4CU73nYJlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gZvwF8h2OXok5xId7ix5VfXM+1lJOnLjJASbDUngPYA=;
 b=IO2BPSfvZUCEInAh5Udy5N8RRSLKaSYEJoEm1bYuToRhehxxOsQgm5XacHifgYL/pbpNA14rT2A3FWkwXFokGdkXKPuy1ILQ2MM1wmEkU+QKaxUKngnuQo03AwJW6u4+UvGtvXDVkDmkfBkYX/yE3dZT4vwCyTiQjhJQa/7TtUO7BB0ZdX0iBbS17+owADbDKLu5s/WLTNfl/ImNTAzwwFBCUwg8tOSTRH6tCJSr2wPcqWIxWCu9VCcYFwE46nv9AOUoYDo01SzkuYkq5Ig2AcsGmUInBiNX1h62n+cV726A6IwXQRT4NsO/SubLJHb1CpGXm2chhz0hb6YoLVwUkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gZvwF8h2OXok5xId7ix5VfXM+1lJOnLjJASbDUngPYA=;
 b=CPtqQaeNW+cdlSFM16KbWezIuYQOGbeWEs8bLffiOdctsUwHzAGhxhVKU++oj7b7lUDQkF57zFKLORUavRK64awU/QXkYPaCq6tNAJzB4ZFZ/X3wAb85VwNnDw6OD0ynWNRiHXGG24/N51IrGCGbQKewcvACFi+O9sVkW4NfpgQ=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by DM4PR10MB6184.namprd10.prod.outlook.com (2603:10b6:8:8c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Wed, 5 Feb
 2025 22:02:31 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.8398.025; Wed, 5 Feb 2025
 22:02:31 +0000
Message-ID: <566e9e2e-8459-4170-9643-48b5e9c41688@oracle.com>
Date: Wed, 5 Feb 2025 17:02:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1 22/26] vfio/iommufd: invariant device name
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1738161802-172631-1-git-send-email-steven.sistare@oracle.com>
 <1738161802-172631-23-git-send-email-steven.sistare@oracle.com>
 <6b0a3435-dfcf-496c-8cbf-521cbb500c5a@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <6b0a3435-dfcf-496c-8cbf-521cbb500c5a@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0P222CA0014.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:531::21) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|DM4PR10MB6184:EE_
X-MS-Office365-Filtering-Correlation-Id: 33ad6f25-08a4-441e-d99b-08dd4630c9ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RVU1Vm93NjJBZDhLNE5ncThJcUtPaG1MWmZneTN5T0M4U0V3d2VXdU9Hekto?=
 =?utf-8?B?Y2s1Y1c3RmxvQUdWbGR3VytwRWl5MWg0NnovaWQ1alIzcUE3Mm5JVzY3QjR4?=
 =?utf-8?B?OEZKSVUyeUVsWUFqajd3a1NaUC9JVUovSmNrcDIrQ05aYnA5Wm03dXp4YkNR?=
 =?utf-8?B?S1dCZkZqMVNyVy8vSDluQjRYcHdlbHBpZ1NxZm5qdUROL3pkK2ZiRWd5bDNB?=
 =?utf-8?B?S3JCTkROaG5VSzRjOFdIYXpPRVNBM1NXem04K3FwZkR5ZUc2ZjJYeHNUM3M3?=
 =?utf-8?B?K0Ezamg3VVE5VXArMUJuUDRkM3JLYm5Xd0JLQkJSQkF0ZGRsbXVCM3ZaTVdF?=
 =?utf-8?B?MFpKWFYvZWh4eFdoM20wT0lxVWJkMGZvT3lVc0hyRUlPVW41bGJ2SmdkWEh5?=
 =?utf-8?B?ZzdybzJodUZlVlJmd0ZDcThDWFo2RHQrcFgvY2dRc1kxRkJuUFRrMHlPY0s2?=
 =?utf-8?B?RVVLOFJzV1Z0YllrOGFFOXJmMHZCRjIrZ3VoeHRIZkJQWVdLK0NtOHNvcm5J?=
 =?utf-8?B?dGhWaGM3a0dsMmM5VEUrdkhSRXU4cWphTVFtOEhMakFyYWxFd05tcVdENVVQ?=
 =?utf-8?B?aUVMcHFjaUtzK01oRjQ4N1BqdjVXR1Q1eENuK2xlRmpWS2dtWGd4Q1JPQXNK?=
 =?utf-8?B?WjczWjluNDkzektYWSsrSFM4S0ZwaTQ0WGV3dXh1NTRPRlVQeU5hMUtuS0Rk?=
 =?utf-8?B?U3NTUkhCRWs0SUNvTEcrTjdWbXFNekZVUHAyaGg5c1hsb0FoOWdENWV1bjB6?=
 =?utf-8?B?Q2tKSjkyUkt5VlR5RHpJVURUSm84emZaN2tTcUFTZ0VvMkNwRFlpcDgrNk82?=
 =?utf-8?B?ZEtKMWY1aGdaRGdMQjFOQ1hteFpYWGNtTG1pK0RPVytCZ09lR2pRYnlnTXVv?=
 =?utf-8?B?UEQ0SGVhS1lIbHd5eDBvRjZUbkNUUVdEcHJlcm8xNU1XbGQ5NDZ4QmhUdjVP?=
 =?utf-8?B?SlRCQjY3TnpaczFlMFIwcGpvb1BqZGE3SjllbHlWR2dibW12bGp2ZWhoOWNq?=
 =?utf-8?B?di84QUFLMVl4OG1WUloyTEV2ZWJhYWRRK3dBQlozTXU4bkF0SERSTkNJQVlu?=
 =?utf-8?B?ZGVmSzZGRVEyYVFvZ3FDSEx1YklmdkVJMGZjeFUvV3lMbyttNzV1RGV2RXZn?=
 =?utf-8?B?R0JnMk1pcUN5Sk9Jd2RXVWx0anUyMnRYQ0lnSXV1Y1BsUEYyR0ZHTDFxdFBt?=
 =?utf-8?B?Q1hRNTRxN1lTWEQ4cks0cEJlRE04Vkl6RUIvSDI5czUzMTVnbEJVOTBXWUc5?=
 =?utf-8?B?UEVKcEhqaW11U0xQcHRnRnhwbWw4Nmx3NUNoaDVJT0lPUjkvR3MybmtQY21C?=
 =?utf-8?B?TTVTZkE3UUdTcUZFbDU2dnppOXFUU2NoajdEQmtHOWg5T0lMVzh0RHVNSCtq?=
 =?utf-8?B?RXVXOWx0MUwyWVYrdmRtcHpzOG1ZRk5wQlM0aVhWai9kb09LcjFHM015Vm1F?=
 =?utf-8?B?UGw3eWN4MHl4Qm9qcE9pRGZRZUd1RldsdnFubG5Xc0lKUk1pY0pibkdMVXNw?=
 =?utf-8?B?WWwySHBXVENqNkJJR2JtOSttNUpFaFZ6TkVxUjJlRldLNW8wWEZwV1FkbDE0?=
 =?utf-8?B?ZGVtZHczTGhnR1g1aENlYnRHMC8zZDE0V09HeExZd1JiTTZQZWtwRVpFdzR4?=
 =?utf-8?B?R20yZG5TM3RnUHRBa3hoS1dtcWZBUTZPWllLTDNtM3c3cTZsTjIrWE5CUU1Y?=
 =?utf-8?B?Tk03MEVvaVVoSFNFWFl4T2VFbjRDbXRDZmgrdjRKVkpJQUU3M3RLU24wWlRK?=
 =?utf-8?B?aGFZMGlJTHlNeitqcFpDQXlmM1l1QnNydFVRNWZXNTg5cjk4NE9GUXFGSWJS?=
 =?utf-8?B?M09hUW4veHlyZEtLSStHVlpiQURBNHVlckZJZEJGZGZVcXl0WjZWandDY3lN?=
 =?utf-8?Q?MxBdJrIWxqctT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0VMRHpTY3lWVWU4emliMVhuYzRTbVZpaGFmTVFGSEh0bTRsQytQMjFKa1RU?=
 =?utf-8?B?TzhpYllTeVhJVXV0dkV0OHdCMW5rbkZzejhkZDdsNHF5K1FhRTF1MWZhQXM1?=
 =?utf-8?B?ZmRjSmdEUXRJaHJCU1NFWmJaRHZmekR3SjFrSEJrOVU0UFlJKzkyT0o4ODhl?=
 =?utf-8?B?bWYvL3FMNjMvVEVGSlorRDE5N2RxdlhLb2xGUi9xeHRxRlJYam40N1I3dDZV?=
 =?utf-8?B?VzhkcjV2SVBVRkV1SEQ1SHBscDRrK0ZhMmhSRTFWRXltU0RoUXp6anBHZ0pz?=
 =?utf-8?B?bEpKaXc1VjNrTFJmYVhLdmJuKzdTd1lYSXdmVjBVVXpRemw5TnpObWxCUy9j?=
 =?utf-8?B?RXM5S2VRRGVBZ0RLR3I4TzB4SzkrUXRrU21MNm0zalhoR1gvNVdjb2locmVm?=
 =?utf-8?B?cTBrY1VhREtSeURFWlJNYXk3RElPbFU2SWRGRTNRUlo1Mjk1dU9RVWhSUEhK?=
 =?utf-8?B?Y2hnZTlEazAvbmxIeWE4R0E0d0U1UFo1SGRoRjV1cEhvSkJzN0xNVkFDS05I?=
 =?utf-8?B?VXJld3NTbGNJU2txT1NDUk9lbkFPODJhemZ0UnZRbll5VkJ6SDdUMkd6dGNP?=
 =?utf-8?B?N1BjRFlNVW5WVWN2ckZWMDhaYXRKUzRRbTMzNWc2NEhVOUtiajlTS1hkbFdl?=
 =?utf-8?B?OE1tZEJvdkdMV2dDUzlSNXVIOWM3L1U4SEg0U25MNWdQczJGSy90cjMramRv?=
 =?utf-8?B?Uy9Yd3RTRnhjN05KOUR4eVcyTU5yUzAxbS9wdlg2WXY1akMvK2JWcXNMbXp0?=
 =?utf-8?B?S244aTBqWmw4WTFEYkFub1pBZE0ydmhwT2JkVk45YkRpTVpVNzl5Sno5S2x1?=
 =?utf-8?B?M0ZLNjA0Zk9NRkJuZ2puVFpBT0c0NmpYS0twS3RaWUlrcDR0cXlPRHFvaWpO?=
 =?utf-8?B?S1lzZi9KeTFaUjY4aTNaUGkxemZpWXIzNlczdWs3THZHcXVRWkh5NDZ1dW9n?=
 =?utf-8?B?dHR4aFlDMnVJMmd5T20zN0RadWRrWm00V09DUFcxMzNCbE5ybjBKdk9ONFVo?=
 =?utf-8?B?eHdDNDhGUGRQbzNFakdGNm12TEVrcmRGbThGUWFMZnJ2elV6S3BaTEovc0hP?=
 =?utf-8?B?cldlWTZhTHVWSUlSV2dLMjJ1bC9WTUlkMkFjSzRDWDBKVHIxcU5BUTIvVnVX?=
 =?utf-8?B?TUdrSk85d0ppZzBER3BRa2hCSGJ0ZXN5SFNoSUFCT1JyZWs2MXZIaHlPV0ZX?=
 =?utf-8?B?aWU2MVVxT1VJY3V3eUpsMU01a1JPMHVQcSsrOU1JTFQ5TGxCbEl2ZHYwNXVa?=
 =?utf-8?B?ZjdrQ1RSYkhRZGg2OXFJamdkMC9FYVBWRUptZ0wxb0xPYS9vYWszK0FZZTAw?=
 =?utf-8?B?T3JrWlh3MmJlQTVYM2V4OVJuVHlnVDduRWE5a1UyRDR0WkZzL2c5R1ZpR2NO?=
 =?utf-8?B?YXJVZnp0VmorRWZzVEtVZXVKUm55cUZydzVlTjRKT1FJNHI2eWltVGN2K0Ez?=
 =?utf-8?B?ODR1ZXl3NTdvY3F2QWVsTmVSU0p1eVhLUlJUVXFWZXAxZmt6MHZIbVBqblMw?=
 =?utf-8?B?bU5wLyt4UjNSV1U3dG5MS1VDKzErMnN1cTVpN1MvSTRYUEg1VjdkU2VSdUtO?=
 =?utf-8?B?aGs1UURHRzdaWThiZFAyYThpM0RoOGxtVGdadjJJSkV6Ni8zd2V3K2dyY2gw?=
 =?utf-8?B?c2M3VEhtcGJPNGl0azZvYUNieUI5aDFHMjR0K0tHRW5GT2EvUzVsTkxITC9T?=
 =?utf-8?B?NXpGMGhXSThBZnJUWWE5MEFBOW9vMnZpQ2hpdUphaG1xMUlnRm1aa0xLZVVr?=
 =?utf-8?B?NUhJV2cxemVXeUx0aGViR2lMaGFvRWJWUlQxaGNRWmNpbXdaeUhkRmUyZ2hY?=
 =?utf-8?B?TERHVnIzRmpZNWpkYUVza2dyTXJYeDBLZG5pb29sTmpMd3I0ZjMyN1RRd2ZC?=
 =?utf-8?B?M05iN015QzB3bWs4THQxMTZKcWhMMm9YNk1QR2VMWDNUYVI5blc2RTBBWERL?=
 =?utf-8?B?THhvMTVrVE4zMm1XMEs3V1AvNFNpLzBMRFZvS1Z6SkZsZTlMR1JkaWh5RXB0?=
 =?utf-8?B?MXo3cndaT1BjTHRxUE1LNEpvakczNnc4ZDQ4eWVmeHJGY3c3SWpnQVdpMnZz?=
 =?utf-8?B?YjRPQ3gvN053ZEtYTyt4bmFpNHpNd0k5Tmx3VUxaaUVZZXJUU1daV3EzNnpm?=
 =?utf-8?B?SlhBRDRwN05RWEdEQXpRbGhLZ25pWTZvUU5jZ0UyNFcvM1paYWdRbHIvY21H?=
 =?utf-8?B?OWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: If9C4YyqI5NpmGJdu3YQwotzKOH9xZCnSGYZjYKz8acRumvQeoD/0kFP+sZMQM2UPVx6icagKIGGvhhEbVy1vFZm40AgCehnNx7M43s1xGfAJXjsr+2JCNSDTUFs0Pt/n55T8gPOrbBM8QAhjT0bCDqE1KzJyRdbJjtNttPNllx0XyHRDQgqE3mgGZ3fZfruIY7ZEpSGlHyh6bEXOAM+Hk3BjPxTOz2fysYzTsBcQyfRuxLWFm9llDJ1QjVW9noQcA/6kr0CrRPZEovOn3ftqYF3BY8z3S6ROILkuFAdHsQzlVGimxgZgq8GY7VCG/SM43Sph8HmKkqmdW4n9yaZ5FUogZNFnOEHmT84LUSFZhxLKwAG+mc9TrEjegK7sS9SdW3myybpWvvoWsvZKHTVSyLIHzA2ICuVTdZcayA3NwyOd3S0pQ9RoHRcBsSY/9kwwT3YtefarF+S0yhGDJPCLIV6imWYSTtEuaojrBYrs3JeV8EGJnHH20llUD57ePMTkyCsPMIhNgARtRw2mltUNALTojfHba78gckmpi/e6CH0yROu0bwzN9uZdWLs9c/l1XSkjAiEba8BeLd1VxPdpaLQieE50WWNsPhbXcNbEG4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33ad6f25-08a4-441e-d99b-08dd4630c9ef
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 22:02:31.8078 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N6Wr85voTKTfiBY9Gi8DIdXQbjy8ffdKrWWj8NWyH+qb91mWV7jMHNHCcYd6WJAFs5sINau9rd5Qz2ZfMEsPASVztn9sBFOtqVSlzDd3jA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6184
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_07,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502050168
X-Proofpoint-GUID: NOs9DYDg3gJwEt61hR1rJM4REH_9a06E
X-Proofpoint-ORIG-GUID: NOs9DYDg3gJwEt61hR1rJM4REH_9a06E
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

On 2/5/2025 12:42 PM, Cédric Le Goater wrote:
> On 1/29/25 15:43, Steve Sistare wrote:
>> cpr-transfer will use the device name as a key to find the value
>> of the device descriptor in new QEMU.  However, if the descriptor
>> number is specified by a command-line fd parameter, then
>> vfio_device_get_name creates a name that includes the fd number.
>> This causes a chicken-and-egg problem: new QEMU must know the fd
>> number to construct a name to find the fd number.
>>
>> To fix, create an invariant name based on the id command-line
>> parameter.  If id is not defined, add a CPR blocker.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>   hw/vfio/helpers.c             | 18 +++++++++++++++---
>>   hw/vfio/iommufd.c             |  2 ++
>>   include/hw/vfio/vfio-common.h |  1 +
>>   3 files changed, 18 insertions(+), 3 deletions(-)
>>
>> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
>> index 913796f..bd94b86 100644
>> --- a/hw/vfio/helpers.c
>> +++ b/hw/vfio/helpers.c
>> @@ -25,6 +25,8 @@
>>   #include "hw/vfio/vfio-common.h"
>>   #include "hw/hw.h"
>>   #include "trace.h"
>> +#include "migration/blocker.h"
>> +#include "migration/cpr.h"
>>   #include "qapi/error.h"
>>   #include "qemu/error-report.h"
>>   #include "qemu/units.h"
>> @@ -636,6 +638,7 @@ bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
>>   {
>>       ERRP_GUARD();
>>       struct stat st;
>> +    bool ret = true;
>>       if (vbasedev->fd < 0) {
>>           if (stat(vbasedev->sysfsdev, &st) < 0) {
>> @@ -653,15 +656,24 @@ bool vfio_device_get_name(VFIODevice *vbasedev, Error **errp)
>>               return false;
>>           }
>>           /*
>> -         * Give a name with fd so any function printing out vbasedev->name
>> +         * Give a name so any function printing out vbasedev->name
>>            * will not break.
>>            */
>>           if (!vbasedev->name) {
>> -            vbasedev->name = g_strdup_printf("VFIO_FD%d", vbasedev->fd);
>> +            if (vbasedev->dev->id) {
>> +                vbasedev->name = g_strdup(vbasedev->dev->id);
>> +            } else {
>> +                vbasedev->name = g_strdup_printf("VFIO_FD%d", vbasedev->fd);
>> +                error_setg(&vbasedev->cpr_id_blocker,
>> +                           "vfio device with fd=%d needs an id property",
>> +                           vbasedev->fd);
>> +                ret = migrate_add_blocker_modes(&vbasedev->cpr_id_blocker, errp,
>> +                                                MIG_MODE_CPR_TRANSFER, -1) == 0;
> 
> cpr helper please.

OK.

>> +            }
>>           }
>>       }
>> -    return true;
>> +    return ret;
>>   }
>>   void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp)
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index 2f888e5..8308715 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -24,6 +24,7 @@
>>   #include "system/reset.h"
>>   #include "qemu/cutils.h"
>>   #include "qemu/chardev_open.h"
>> +#include "migration/blocker.h"
>>   #include "pci.h"
>>   #include "exec/ram_addr.h"
>> @@ -657,6 +658,7 @@ static void iommufd_cdev_detach(VFIODevice *vbasedev)
>>       iommufd_cdev_container_destroy(container);
>>       vfio_put_address_space(space);
>> +    migrate_del_blocker(&vbasedev->cpr_id_blocker);
>>       iommufd_cdev_unbind_and_disconnect(vbasedev);
>>       close(vbasedev->fd);
>>   }
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index ca10abc..37e7c26 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -147,6 +147,7 @@ typedef struct VFIODevice {
>>       VFIOMigration *migration;
>>       Error *migration_blocker;
>>       Error *cpr_mdev_blocker;
>> +    Error *cpr_id_blocker;
> 
> a struct VFIODeviceCPR would be welcome.

OK.

- Steve

>>       OnOffAuto pre_copy_dirty_page_tracking;
>>       OnOffAuto device_dirty_page_tracking;
>>       bool dirty_pages_supported;
> 


