Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16F72CA0EE4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 17:20:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umbcy-0002hd-M6; Thu, 14 Aug 2025 13:20:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1umbcw-0002gt-Qm
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 13:20:34 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1umbcu-0003iH-AO
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 13:20:34 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57ECgGiJ002183;
 Thu, 14 Aug 2025 17:20:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=49aZKONmO5UPtGI9mxE24t3L9fcQ+QLDOuO78A5WxCc=; b=
 R++w1YH/wr+L4DM59dIQAHnf9vm5Om6JbMgfxH2mN56dmq+jOukzzX5i2Enls+H2
 DZaF+wtWKVSNeyf4gQL0RJ6MOvKVYU9AcOeid2MOw1wcJwE82DkGfBRFtQPt0Fdq
 2naTUAvfqDfeeasZ1uFLCoPG4K/UCa9/mIXodbPE/TEkTldbvBsY9s8mBdsW4XEB
 RywkL18ze7gTk+FykI90/nXBGqLGayuqgQ6Q8iUUV8baOY2vqe+9zPAcpzEP40GR
 MOGKzpB8x31zheWYo7ta/i/7UkxVLJIwHx3IXq4o6dZDoukWF+WZOECY8fpzDY+c
 EXvFpgLsGNbFZjoAzDWimQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dxvx2dax-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Aug 2025 17:20:29 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 57EGg4em030111; Thu, 14 Aug 2025 17:20:28 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 48dvsd1gvj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Aug 2025 17:20:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g6ezSD0WTCN0sDm+2/3Hm4TVo0ieViWT6iX27ytZEc1CZa/jwZ0ObbEdZw0e6L78q/bSwkMkugK/A48v0q64ExiRQ/gHurp33fQUAcRjtfkpBAGf3bSBbrUEzrEqtjky0OhLuagkSQRD1Si2ibFzhNKKrzUfZgk6r9wpoKinmSqJsOmjcPuoZEjMpU11SCCy/zF+9EuHsJc0Aao7Mo2QmVPFoPJyyKE7UtBYwbyPmTyZXyKlVHb82tpi8SfIbjReyrTPjNqDW0YAn7uWNpesgWwaUc/jr7sT5UlAU/7sw4+1C1XYyWivGksVuWMH8RI7U100kGoqoTtwnOH8eesKRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=49aZKONmO5UPtGI9mxE24t3L9fcQ+QLDOuO78A5WxCc=;
 b=h8x9/vR7KvoOtLqWDfAMvPvn/3Ii+lMLzpd0rPeI/cieyGJOybtXdoPfLFVLr7BdQMKFejw3k4UjNQ8SVtXCZV6sE37+Va6u90ugTnC1JqMgDQdCoZtYD+NkI2uDMIRezc8UTw0M4BAPsbkDmaCQz9npEdXT+Yu5BFvCVmJe/TKAoDNM4IC2MZlNy6F738Nn7lYt/pOUAHwXuLu/RGh20bUDt6XwXqJpPBeIXf5RIbg5goY/+SKbheMdG40rouwUggnmCB60C8Y3/OwmuriEiY9MuSG3uHdSonNIibfqBeZ79ZQU47q5mzyYnRib/w3n5yLcBabWxiP/cCTAu43KaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=49aZKONmO5UPtGI9mxE24t3L9fcQ+QLDOuO78A5WxCc=;
 b=Zdhj96zs93U7NSuI5Td/SUCg0dtOjqIRJeN/WlOnvE/vJZ1GRgrfzxZb4ZMaRgvv/Hoiv+zglnW3Tizmr7m+rywIhA1dFz1qC3rzyM0kX4G9ROslXUzwN2NaK2rs12C0VPK3Aouc5Ece65mallrgIE7kwad8TwVTh4XP7WSe5oM=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by IA1PR10MB7197.namprd10.prod.outlook.com (2603:10b6:208:3f2::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.27; Thu, 14 Aug
 2025 17:20:25 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.9031.014; Thu, 14 Aug 2025
 17:20:25 +0000
Message-ID: <92976018-2b44-4177-a26b-1f5c7a433d11@oracle.com>
Date: Thu, 14 Aug 2025 13:20:20 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 9/9] vfio: cpr-exec mode
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>
References: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
 <1755191843-283480-10-git-send-email-steven.sistare@oracle.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <1755191843-283480-10-git-send-email-steven.sistare@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0001.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::14) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|IA1PR10MB7197:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ea7b73d-7c7f-4395-8822-08dddb56db5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cW9saG9BcFljWVloU1FBOEdZYTZxUXRLaHpUdG9tWkdLeUhEMzhYS0JjeWhS?=
 =?utf-8?B?Yzh3VlBJd2MwZUtUYnd5Zk5hVEN5RlJwVXNkcE5LK3BaOExsMk5EamxmbG9j?=
 =?utf-8?B?b0JmZVAzd2E4eDMxVHdHb0NLMGZFcHRXQVdvS09TTkw1Rm82d0c4dUlVTytE?=
 =?utf-8?B?WTdEaVE5c3IwWmFiQnJVT0V5U3VFVU9qN3o5a2NvNExFenFWRERDU3F2YnI5?=
 =?utf-8?B?MGFIMWxrVW1xOGRCOEhIRTE3VGZaMG9kRXZySVZENU9CZDNTUGhic0o1MTRq?=
 =?utf-8?B?VW1mYml4S3lyZHd0djlRdlAzRHNDMm82aEFQak5MQ1BLdm53MlQ5MDU4T0d6?=
 =?utf-8?B?R29oQlVNc2xzaW5mM21lMmhoSnMzdG00dlZDaG52TExyNzZFOTRqTTBKSHJo?=
 =?utf-8?B?Rkdwd0pGQTg2L3NKNXNjUGthb3cxV01HWWxsOEpOR29hZVc4WGlmOHVndUZB?=
 =?utf-8?B?NUc3dGc0Zi9KWjBBR2Y5bnRQR3o3VHltcC9iOTEzWHV5dTVkSFBJZTI0b2R3?=
 =?utf-8?B?eFIvQllDYTJlRUorL3ZrRWcwRXpEQkNHNVZMc3BVWnNpWDlsR2lYUDBFb1hO?=
 =?utf-8?B?TEZ2VW9QTE93aFhyeU1hU21xa0twUzIxL3ovcGV2bzd1QjdmNXJPWXJvTkpB?=
 =?utf-8?B?OWVDRXR6WUdiQ0Z3bnFZMjc3cVN2THNvaUJyOG9ZczJRNEhBU21vZklXN0VR?=
 =?utf-8?B?SXRSTlBxMFQvaG9BZlZSQ1gvMWlpeWlnbDhRRzhGY3IxZ1F0cGliSmQyUURV?=
 =?utf-8?B?Z2k2V2ZLLzJieVNLRzRkckt4cUJ5Vk05UEpRUGpyTXNHelZSQ2R0TGFnZDZs?=
 =?utf-8?B?UFBadFZkbnMyeWNQR2RzWFdhZ01PTFozSloxd2V1TUxhVitBcEtoVG5TMVZE?=
 =?utf-8?B?OC9laW5ocDdTT3JmMkdmUUxxWW82dndCRmV6VE1aNVVWU2h0cFk1c1QvVWR0?=
 =?utf-8?B?d3VQeVNVTXFCSEtnNnZDQmNGUkN6QXpIYm93TkFiYVlnUlBRN3hBUi9mT01M?=
 =?utf-8?B?TnBRalhlc1hjcm5UMU1wNUhPaUVVcHFsVDQ3RXJOYUcvSExYRnM3VTQ1dUU5?=
 =?utf-8?B?Y0FDckVqeVJaUWQxSExscXB4bUxOa0Z2U2FIU1lBUE9CVytGb2xwK3RnK21j?=
 =?utf-8?B?cDRIZWpEUWxuV1ZYNEN2TnVqTnpzUFRvMU0rWDFSaUNZZ0tITnhjc1dYTGxW?=
 =?utf-8?B?MEY3ZWFHYjcyUUpSUDdFVGZFRjY5eVF4dG5hcUdaajAyQUZKQ2p5MktRNFlX?=
 =?utf-8?B?ZUlvOFJQcjArME4yM1RlbjhTc2xzbkpFTlpEZUozWGZGamc4dGw5eEZVTzUy?=
 =?utf-8?B?UHcrbnNnaW5LMFdSdk5EVzJYTDdRaWtkN2N0dythYjNyU0VLbXNtZGl1UHpl?=
 =?utf-8?B?YWYxbFY3ZFpscFNOTG1KcERpbjFTK0tOdVlCNXh5RjlqVmlKM2lEVHBJeENy?=
 =?utf-8?B?UmNIZW0rRFAvT2QrOHZkVHJQTmpLLzI5OGtIbTk2VDBzK1hnYkQ3clkxR3FF?=
 =?utf-8?B?NFRkNDNJV2F6eml2bXBBT0c2dmZ1ZEtieXpYRzdnaWlvS3pvc0dPd2crYmlC?=
 =?utf-8?B?ZTgvZys0WFZZaGhHQUpvZkk0a2xxSHc4OGcyajRHcFpiQUwrL0JwaWErMm5x?=
 =?utf-8?B?L0h4QXlYZXlRT2IzY1VlUlp3aDZYUEIyMCtDbTlxUXd5NVlnRCsxbkJ4S053?=
 =?utf-8?B?d1FkNXA0NzVOM2lydmE2c1p2WnBVUHovN3QwZ29GOVlBaDNVUlhNZy9YTzNB?=
 =?utf-8?B?OVZzaDl0Mk9vQ0hDaUszUmVIT2JrTGJ1UURmSUZmTFBHd0Z4TzFNU1pEcXIy?=
 =?utf-8?B?ZnU1eFRaZUx5QzdwajU0U3lta05IbmR3dVBFT1NnQVJNdTJtQTJFeERRSkMv?=
 =?utf-8?B?TlRQMytyeGxQcVgyZEh1VmNPRnE1bjRLZE9pc3FZN3FmNW9ObUEyYUY2V0tv?=
 =?utf-8?Q?4X6/fv9G2EM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDhPQXFFT3BDS1liSmhqUHdIYUV5OE0zL29US056bFpONmQ4UThHOE1lZVNO?=
 =?utf-8?B?YVNlNDBRWWN6clFWbmZPekdvNlIxaDgzMS9RaUY2ZHJmSW9PeU1rQ1ZSRHJj?=
 =?utf-8?B?OFBRRDYzekxidlVhdjFXUUpuL1luVys5cHJzMzlnekhTM0Y4dHJCbnNSSThr?=
 =?utf-8?B?bXYyVVJudi9sWE1IaXVzVWx6MTNnQzVHWWFNKzNOM0N0dnBMRVB3VWwwMFVC?=
 =?utf-8?B?MVhOekpHbjVVcllMQm1TZ3IwcFloTDhSSlE4NW9zRmtyYktlamNrU1BKZ2or?=
 =?utf-8?B?RSsvQlBHTXFFUjdHaHphT1BueVZOaHE4VDRldzFyenJBWHdXZS92QnlFQXYx?=
 =?utf-8?B?WmVMQmpmbG5sYjZFVGp3cHhiU0lhRHZvOHloYm4zK0hBMC9pZ2ZJNDUrRTJY?=
 =?utf-8?B?MzFLYkYzZktQSDZjSGlKS1JCT3E2aDU5dWIrMTVYbU5YK3BRcW5aeXZManFM?=
 =?utf-8?B?c00vK3lmKzcreHFDL2RLMVdNVDBUNytMOEhvMHVLK0ZLQnp1V1NwdElBRUh3?=
 =?utf-8?B?b0FlZnJ3S0xFakFZb2IwTWJVZEtsUm5JLzNPaWsrenpUMVBkOVRrWUFoMHpS?=
 =?utf-8?B?NWw4cUNrTDMzYkgwcTNmMk5OYVQ4NEdpUkhiTU52bldLeXI2WFYzcTMxNmxi?=
 =?utf-8?B?VHFrSmlqejV6YmZLM1lhQzN5dFJkamF5TnVoejhSMkFBWWxCWVpMUVppbVF5?=
 =?utf-8?B?cUNEVjk3am0rYXI3b2VpYko3UTdlNFV2Tlh1bHlTNmlrMGZIL3ZhMVpqOEhW?=
 =?utf-8?B?R2ZFVGxrQkc1bE1lcnVrWlMwVGJwTHVVbmJ4bWZCNDgxOG1RUWp1NkY1MVQ2?=
 =?utf-8?B?N21GcUtRajlONkVnYW5OTUtIMXFQUzhmelk3S0JXQy9idm1GTExWUHRMejU3?=
 =?utf-8?B?aUZpRG12MjZsNVoxUmF2OGxudHlMbW9pdUk0YXpLMnNUbHRzd1drNFNQZVlt?=
 =?utf-8?B?a2NLVkNLMUFxb3J1T2ZlL0hqZ1hHcE0vdExTcUZMVWJlbzNFaXJoaXE0ckg5?=
 =?utf-8?B?Ri9lR2lXUkRTVVlpcFRhWlhHRmhXRC90dkxHSG9iZTFXMTlNQVJObE5BUHJj?=
 =?utf-8?B?eGtYOW5HejNxV3ZjUWwzL3NZYnNmc0c4azNaamRVUUxVK3QwR2lwdXRZL3FK?=
 =?utf-8?B?a3BRRE00TVRQRTkvMW1MZldubWhQeCt1dUVQZW1uUGozVEtHU3NLcG9uUGto?=
 =?utf-8?B?MktEOFdCbGJLWXF3NVI5Zlc0ZDZIalNJeGh5MHhLTlhyRnVsNjE3OWtCeHRK?=
 =?utf-8?B?YlYwZHl2TUp6K1hobm9tY282NThyWWJnZzVsQTNyWWpFdDhsMVUwNHZkd0NM?=
 =?utf-8?B?TEZyaThqZFhwd3BpdTh1Wk9WVnduemRMUnlqMGtVenQyc0J0R1FVMjdEWFVl?=
 =?utf-8?B?TjNWZmdKYzl4dlhvdkxjVUZHYXoybGJLMEZUd2s1STd4bkpjZ3NXMFhicG9I?=
 =?utf-8?B?aTgrUW5oSXJFSGlMVW8xSWdSaElEanVXelJrbTIyK0tIYk5FZzBTTFBRV2R5?=
 =?utf-8?B?U29ueTFKUEMycFlGNVF5aWxab1Bxc1FaZVlDMncvdURNKyszYzJsaTJqTTBU?=
 =?utf-8?B?anQvcGFsa0NUNEZOMTBDdUtvblhUUWJvbG9XSnl2N09pOTd0TGJSWThZWjlF?=
 =?utf-8?B?cUJ0QUhBMXhxSXd1ZjZsODBPdHRhVzZuWVgwR0VtaCtXRCtsdnZjUTRHTVZ6?=
 =?utf-8?B?K3JiVXhOQmJ0N1FPR2lSUHpHQTZzdi9admNSNS9FSXYxSTRlTlk5L1J5Q0dM?=
 =?utf-8?B?RCtzdU9CRDZQVTJURjdpT3lwQTR5VjY5cjYxbko1bkZwY1lMbllCaUwzVWsy?=
 =?utf-8?B?Vk9PTHNUQ2djVjJjRDU0MEgrWUVjQTNsRVE4VnFKZXErUHY5RXMzZ0VWQ1hN?=
 =?utf-8?B?TG03RGtuNERoWGcyamNrRXFWZU5RUTVadkE0ejJCVC93QVpmMS80QTBNb01u?=
 =?utf-8?B?bDFBMDFVbXE0ZEwxV3NXeFduN21TZjlXdWY0dFZEMDNhUC9kalpvVldlZDkr?=
 =?utf-8?B?ZmVHRmltU1ZhVVhZNkNqQ0hCbTZvSWRwUTIzemlhL3MxSEVPQ3o0SlJsaEhj?=
 =?utf-8?B?Q2VhaVUzL3J0cHk0aUViVng4YnhwRzdzQU55OGFCYUJLeWhQb2loVWtFVTQ4?=
 =?utf-8?B?eThpeEdRWmQzYkltY1I1eE45RFM0WExUdlJvek9JK2dSRTA1dFo4ZDcrMFY5?=
 =?utf-8?B?a2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: /mZXkN2QZQ6egdoTca1kRYFx6tzLcrshomUGvuI7Xc1uRYZxSdk45VgOp6tnA0V8m0Fl4ThA60E0ypPJmp6dLP8igicuHwY/6Q+IO0KwKcapNiteRltCTmGgsQt75NO7WB897lgLGGW6Wria5qaWW5nrLjc7+uyV8UQ7tNSUL5tQRMaG14dPhtYL/FYasv87d+62vh3Nga/I8ASWTODaXy9FPo4cC2qGZAxwDP8hP2eMQYb8LUsgEZxK7QmewfJTmWNSI2FQSEjnaJUmoBTJJkUbW12MqkRRtg6dTW5+YOr3HY/poB4fO9nB+jTW9tBR4Qbh0BB7NTrnMOG52mMAfnssEQ+ex1Qx4ka22z0hdctOrWA5tOVvNEU75TE2+BXD9IlKk3NLdJbBNqE9s4aQzWCz0iN1+pk6j8W2w0pBWgvh/yvCtNeLXBmfXAK2NN08vAd6nhduJDXs4UdLH5Xm6EA46WE5rAw7p2hF9zkTdkaPEZaVgSMPjnuaH6eupbVYuAPgWr9OsyOkmsvf3AZ5lDjj7ZTGu33mfAT071k7xv105ZkckB9ZRyiloGIUW6nz3V1TZ7g9JRS+rYgDymlGNAMlJth18r0nhzn8J2vm4tY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ea7b73d-7c7f-4395-8822-08dddb56db5e
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 17:20:25.3320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eiXFzftiNEfI7kRFAn0Ddi1/jBEHkisE3+hmR3mYZaj7QjAvUGDWmXFXdVvg2Xjy44v7nrp3vpolHsJigZ4TvFkoWxvGftaMaW5nucttNyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7197
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508140148
X-Proofpoint-GUID: BVGjAFDH9qpM7FIpk1_V9S0VsrDZifm_
X-Proofpoint-ORIG-GUID: BVGjAFDH9qpM7FIpk1_V9S0VsrDZifm_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE0MDE0OCBTYWx0ZWRfX7GYUc7rUPunf
 y1v8yfFOhL7MMXxZ7URGTO9KJIdeQXG0Os61H59UdKy9WbobBHaKe0Jl/BU91m3sFiMpFBYywU+
 JZS9NdnxydSiHHOMekciMEZJywX2ZXwf/WUKvzGpSL4U9cunutJTcbFXpCjwVaZ/kpu9WQNsmNc
 rRzMBL9MMltHwHHoU4iA/SxMyBcjXiRQgn0CstV5FtdzBhEXIo6e0yQwGJ0D1FEe2AkoixZQobL
 7lHGgGrnf5VS3KYIMlD7i7g0fBICOIX9FhomZiDAqXkmlxaWxBZXvcw0awAjxdPYBH5P5ktViLN
 tvqnUbGI0wB1HnuRmAJf4QnkZxCFJfkrYIzShUC/o/JhwXuMYtLv8LUsbv2QPV1xZ8VFIU+sSwg
 sy6gSFmriWtfQzDGXHI87FD59b9NshY9JYWJM/kyS76fqOFWZo+vRY+6JoOJ24Ka/wx2CV0r
X-Authority-Analysis: v=2.4 cv=dpnbC0g4 c=1 sm=1 tr=0 ts=689e1add cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=AYPOezwXLu5bqwt_OaUA:9
 a=QEXdDO2ut3YA:10
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
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

cc Cedric and Alex.

This is the only patch of the series "Live update: cpr-exec" that touches vfio.

- Steve

On 8/14/2025 1:17 PM, Steve Sistare wrote:
> All blockers and notifiers for cpr-transfer mode also apply to cpr-exec.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>   hw/vfio/container.c   |  3 ++-
>   hw/vfio/cpr-iommufd.c |  3 ++-
>   hw/vfio/cpr-legacy.c  |  9 +++++----
>   hw/vfio/cpr.c         | 13 +++++++------
>   4 files changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
> index 3e13fea..735b769 100644
> --- a/hw/vfio/container.c
> +++ b/hw/vfio/container.c
> @@ -993,7 +993,8 @@ static bool vfio_legacy_attach_device(const char *name, VFIODevice *vbasedev,
>           error_setg(&vbasedev->cpr.mdev_blocker,
>                      "CPR does not support vfio mdev %s", vbasedev->name);
>           if (migrate_add_blocker_modes(&vbasedev->cpr.mdev_blocker, errp,
> -                                      MIG_MODE_CPR_TRANSFER, -1) < 0) {
> +                                      MIG_MODE_CPR_TRANSFER, MIG_MODE_CPR_EXEC,
> +                                      -1) < 0) {
>               goto hiod_unref_exit;
>           }
>       }
> diff --git a/hw/vfio/cpr-iommufd.c b/hw/vfio/cpr-iommufd.c
> index 148a06d..e1f1854 100644
> --- a/hw/vfio/cpr-iommufd.c
> +++ b/hw/vfio/cpr-iommufd.c
> @@ -159,7 +159,8 @@ bool vfio_iommufd_cpr_register_iommufd(IOMMUFDBackend *be, Error **errp)
>   
>       if (!vfio_cpr_supported(be, cpr_blocker)) {
>           return migrate_add_blocker_modes(cpr_blocker, errp,
> -                                         MIG_MODE_CPR_TRANSFER, -1) == 0;
> +                                         MIG_MODE_CPR_TRANSFER,
> +                                         MIG_MODE_CPR_EXEC, -1) == 0;
>       }
>   
>       vmstate_register(NULL, -1, &iommufd_cpr_vmstate, be);
> diff --git a/hw/vfio/cpr-legacy.c b/hw/vfio/cpr-legacy.c
> index 553b203..7c73439 100644
> --- a/hw/vfio/cpr-legacy.c
> +++ b/hw/vfio/cpr-legacy.c
> @@ -176,16 +176,17 @@ bool vfio_legacy_cpr_register_container(VFIOContainer *container, Error **errp)
>   
>       if (!vfio_cpr_supported(container, cpr_blocker)) {
>           return migrate_add_blocker_modes(cpr_blocker, errp,
> -                                         MIG_MODE_CPR_TRANSFER, -1) == 0;
> +                                         MIG_MODE_CPR_TRANSFER,
> +                                         MIG_MODE_CPR_EXEC, -1) == 0;
>       }
>   
>       vfio_cpr_add_kvm_notifier();
>   
>       vmstate_register(NULL, -1, &vfio_container_vmstate, container);
>   
> -    migration_add_notifier_mode(&container->cpr.transfer_notifier,
> -                                vfio_cpr_fail_notifier,
> -                                MIG_MODE_CPR_TRANSFER);
> +    migration_add_notifier_modes(&container->cpr.transfer_notifier,
> +                                 vfio_cpr_fail_notifier,
> +                                 MIG_MODE_CPR_TRANSFER, MIG_MODE_CPR_EXEC, -1);
>       return true;
>   }
>   
> diff --git a/hw/vfio/cpr.c b/hw/vfio/cpr.c
> index a831243..a176971 100644
> --- a/hw/vfio/cpr.c
> +++ b/hw/vfio/cpr.c
> @@ -195,9 +195,10 @@ static int vfio_cpr_kvm_close_notifier(NotifierWithReturn *notifier,
>   void vfio_cpr_add_kvm_notifier(void)
>   {
>       if (!kvm_close_notifier.notify) {
> -        migration_add_notifier_mode(&kvm_close_notifier,
> -                                    vfio_cpr_kvm_close_notifier,
> -                                    MIG_MODE_CPR_TRANSFER);
> +        migration_add_notifier_modes(&kvm_close_notifier,
> +                                     vfio_cpr_kvm_close_notifier,
> +                                     MIG_MODE_CPR_TRANSFER, MIG_MODE_CPR_EXEC,
> +                                     -1);
>       }
>   }
>   
> @@ -282,9 +283,9 @@ static int vfio_cpr_pci_notifier(NotifierWithReturn *notifier,
>   
>   void vfio_cpr_pci_register_device(VFIOPCIDevice *vdev)
>   {
> -    migration_add_notifier_mode(&vdev->cpr.transfer_notifier,
> -                                vfio_cpr_pci_notifier,
> -                                MIG_MODE_CPR_TRANSFER);
> +    migration_add_notifier_modes(&vdev->cpr.transfer_notifier,
> +                                 vfio_cpr_pci_notifier,
> +                                 MIG_MODE_CPR_TRANSFER, MIG_MODE_CPR_EXEC, -1);
>   }
>   
>   void vfio_cpr_pci_unregister_device(VFIOPCIDevice *vdev)


