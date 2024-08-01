Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11898C3DA7F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 00:42:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZJt8-0001yQ-2B; Wed, 31 Jul 2024 20:41:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1sZJt2-0001xc-Pj
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 20:41:46 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <si-wei.liu@oracle.com>)
 id 1sZJt0-0003bd-2c
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 20:41:44 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46VLGv3R004709;
 Thu, 1 Aug 2024 00:41:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=oAh6hlLAt97uAXPDFygkuwRfmmxe+v+X3KtLIiP0C9w=; b=
 XfDHs0+kuUBZngryXAMrZ+XpPU8uMB+40rWROzD+cSAPRhnNM6Fc7bvVYuw5w5j3
 hZQ1qfdDg1sHCx3uDG3Pz3Lp6P0vqLs0zpYOT+UmzzUg2lpWlFVhjuMw2TPxlZMX
 h1c3ClAf6lUG+oU6W1qeYHcfIYafyE9MB63qTbugbqF1NqWLG8pD00tJDWhzs34G
 XSPuq1CQQQoPe7R9UGaS6iVsqJjzJS0Nm6O6sIfj1hhhXeYPftmqc9Z5LMnUcaZ6
 jglaz8Gmp8lvOcphOiRf+tbt5AFQIStEee0dRH2tzh47x9FPRT/bVwh6rEZy6plF
 SjTUW8mWu0Up8dm4DMbz0w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mrxc0rv7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 01 Aug 2024 00:41:38 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46VMM1d3019018; Thu, 1 Aug 2024 00:41:37 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 40qjmsy648-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 01 Aug 2024 00:41:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kLFWAu4QRvV/1hsaGwSd8J0q7heIgG2ejwcBBeeD+xLfxdJGuBPZRVDwPUbZANAHQthjAwP5fyR2I8yaV6IgVN9UdR7l9jPPU0u51r4Hos7EY1hmcLploFyP6Fzctetx0nd23aVl015GcM+xa4laN0eB8uk2CCzAUtKs6WKQJnMWPv6IACTUcO3FAmyHmd/fqJ+TAT5q1AC0XxOn7fpJGmoOeLIG4BFirWbzqwWb7oTwjEMXW8/pl9M/oBhAfNaZxwYzXB3Ytk/biRpvR0tlqRxuGmQL224mwtYD6VFAhsBy7T8SWpU8FHTcSCkHdr2jrXcpmt6aldl3g7w1diI42g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oAh6hlLAt97uAXPDFygkuwRfmmxe+v+X3KtLIiP0C9w=;
 b=hZqsucKnp4LL3RSYUunfOykdnp0vV/An5jYKFBp5nVAwitJq+72v/xLi2CvS6fhCEqXudvw2f9TWsdHKXIEuIqrEi+HnqXWLzrLH8BsnN3Y0oPbncgjxXQIs7HyWuPw97A/eUH+QD1QvrVPo/EIKTy0RcUO3p0TLg1DFAkdheoJtKMVrCXyCFBv4ayYamehFaZQsMeaiH+xRnFuLMif0i/HKF7RppdDsCk/lzfCiEyZrSN/in9ieYW76lHJJqbQFbruDAmnuAOQ0WhUYvn5mlhTaoTpg53eVEPt6gCch67E+Qvz9X8hzw7xKyMd82jAxlWHUBpWW0hFgiiYaSF0sxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oAh6hlLAt97uAXPDFygkuwRfmmxe+v+X3KtLIiP0C9w=;
 b=Aga152y4P6FUFs2C+lhJDq6SU4F6pGbI9dn+H4Ll+BaedmTdBv6uHqYe49aQRGZsMNfWlp9Lzfth3ONDcSkqQQleAiRI/WbLWit/V860HwDuKp64Kq5QO3rw3U24gn68167WHHkgmMBtagN46jk2BK+zzOTjnQ8TFx+zcZ53+lY=
Received: from MW4PR10MB6535.namprd10.prod.outlook.com (2603:10b6:303:225::12)
 by DS0PR10MB6821.namprd10.prod.outlook.com (2603:10b6:8:13e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.23; Thu, 1 Aug
 2024 00:41:35 +0000
Received: from MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::424f:6ee5:6be8:fe86]) by MW4PR10MB6535.namprd10.prod.outlook.com
 ([fe80::424f:6ee5:6be8:fe86%3]) with mapi id 15.20.7807.026; Thu, 1 Aug 2024
 00:41:35 +0000
Message-ID: <50fd84e1-a8af-4c61-90cc-2ceb653869f6@oracle.com>
Date: Wed, 31 Jul 2024 17:41:32 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/2] Identify aliased maps in vdpa SVQ iova_tree
To: Jonah Palmer <jonah.palmer@oracle.com>,
 Eugenio Perez Martin <eperezma@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Lei Yang <leiyang@redhat.com>,
 Peter Xu <peterx@redhat.com>, Dragos Tatulea <dtatulea@nvidia.com>
References: <20240410100345.389462-1-eperezma@redhat.com>
 <CACGkMEv7wukFdXrA--DzA7U7VYWQq6UAVmi-0=pTAOuJ1nc_7Q@mail.gmail.com>
 <CAJaqyWdtdfbQi4PrbC-ASRo7dHsT7Nw3dmw66K9D9ZeoqyV=ng@mail.gmail.com>
 <CACGkMEs=-teddtO4ctLdJiwm2gu3sZrKOww-TC+5o2_19Sph4w@mail.gmail.com>
 <CAJaqyWeKfVXYj61sgvFrUTpOgy0k-zsLoR4JePEo0Q8XuXYbmA@mail.gmail.com>
 <CACGkMEt+TLqpbw2N4m7Ez4edTBztRUxiAt6=NLuFR3c7F7Z_jA@mail.gmail.com>
 <CAJaqyWc18UeBHeQSoAFF1u1nkjaAfj0Y85pgSHbhV8xxExjcgg@mail.gmail.com>
 <CACGkMEtrPAMb-ZN7AAE8cjEzjZY1Hnm29J7PhUYgwv26=YcdQw@mail.gmail.com>
 <84374c5a-d937-4cb5-aafb-45ad75e2d837@oracle.com>
 <CAJaqyWfekhhG+5Zp4eddpp-2N=SjUL+7zs+YqS5xx6eWxa-PqQ@mail.gmail.com>
 <CACGkMEvYSBZpVG2x6q_viekods+QWrjoCETQcsgnHM+Ng4NWGw@mail.gmail.com>
 <CAJaqyWfm1zjU-eQ-j+GaWMHGt7Dk5nGUCUEA75yCga9sBxu39Q@mail.gmail.com>
 <2b2bf1a7-9ba9-4da9-b220-ce516ac029cc@oracle.com>
 <CAJaqyWf-Tcu0RdiWU3m9P07xJ7c33QXwSDH0-D=8u2FHC-=uZA@mail.gmail.com>
 <15d9fb93-58f9-4078-8f07-2ebf0f228d3b@oracle.com>
Content-Language: en-US
From: Si-Wei Liu <si-wei.liu@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <15d9fb93-58f9-4078-8f07-2ebf0f228d3b@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0048.namprd11.prod.outlook.com
 (2603:10b6:a03:80::25) To MW4PR10MB6535.namprd10.prod.outlook.com
 (2603:10b6:303:225::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR10MB6535:EE_|DS0PR10MB6821:EE_
X-MS-Office365-Filtering-Correlation-Id: eea881e0-07d6-4384-671f-08dcb1c2b225
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L3NENjliajBxOTRjcEEwNVl6RWlqdnd6b3pvYkplUHZuU1BKN3VUQmVxVm8z?=
 =?utf-8?B?UDVRU2lld1p4SldjaFVuU3VzeS9haFFiSFFhb2JzOFlBb1JoRHpybXdPaVI3?=
 =?utf-8?B?M0ptT2R2QTZlY2hjcEM0TWZTN3ZYaVZQaE16cFUvNnc1bk9wT2M3blNSV3Yy?=
 =?utf-8?B?NFlHSmxod2pzNjlhWTYwZFh4bVNHQTJuV2tWNHAvQzZrRjFLVHZUQmtuM29T?=
 =?utf-8?B?MjA0Sk5uTHRsYUtoM1BVeUpaTkVTdHl1QjZLYmViVllkQmdnZmlzdUMwZjZU?=
 =?utf-8?B?NkJvU0hrWVdJRUpKR2lwZmNLcDF3TUIxcmJlZFZuQWR0QVJRWFgxSUE4ZUpY?=
 =?utf-8?B?MzNSVDFhbCt0MHZSVjNCSmJQNU1kSVk1VG9FcXNUZE5zdEZJdVYxMHdLVXlF?=
 =?utf-8?B?RkJZOE5jcDZTaTIwdlRRMUlJUzUvK3E2SkxNVTFBaHh1R09JbW43ZVFjRHFa?=
 =?utf-8?B?Rnc4RWF5dmk1OHU3cHQ2YnFITmo4K244dE9vVnp4OWU1bWdaVmxqTFVhSlVL?=
 =?utf-8?B?b1pyMWpuajRnbzFVbERKV1NqekovT09UTzE1UXlBY21qNmxoUUhvL2lJSDdF?=
 =?utf-8?B?RXBqS3ArVThWc0cxMUt6bXBKTlBsSHZTRE53U0hDZWhIKzJ2VkV0Z1NkV2Ew?=
 =?utf-8?B?Y3RYRmpBU3BQRENkWTZlNjBLQjR1NXRUaENKYUZqVmY5WSs3R2oya1A0RjVl?=
 =?utf-8?B?TjJ2c205RnpIanFnOWsxb1J1Qm9wT1BLZmxtQlEydzlMTUVZZE5ibi90KzRw?=
 =?utf-8?B?c0xUUjZ5dzdSQkY3NTVQalRicURLaFpwQnVNcUxTdDI3Znd5NWE3aHFDemht?=
 =?utf-8?B?RkE0a3BsSHh1N1dHMlNiWU5FL0pWc3hQbVRGVTVPaVNkQUNCSk82WnBxZS91?=
 =?utf-8?B?ZnI5QnRiTXcxdG5HM1lNMXM0OUd3NkZwMlpNQUx6cnBzWmkrYXhDY3poTkUv?=
 =?utf-8?B?Vnh4eUg0RGx5QU1MaTIyR1pXbmNoZVFwMDFjcW1qdW1kcTJwd3ExVm54UndB?=
 =?utf-8?B?MXp4OC8vaGtVMS90dHVnNGZXL2ZkaGZHdk9JT05hcGdBcFJzRG1TZ0tqQXhn?=
 =?utf-8?B?bjhKcG9GWFdZOWNYbEtYQUlBYko0M2xYYnFXY2dhby96azJaSEd6czRWbUh2?=
 =?utf-8?B?RE5LSEptWlhoUXlKLzhuTEg5VHo1MTM3RC91UDRLYUdGSmVTV0VROVZjL1VR?=
 =?utf-8?B?RzVZb2lSMjNBdG9ieDVsbGVPNXhLeXZwK2dwWm5NVUh5ZktENWhrOGFkYmIr?=
 =?utf-8?B?Q0VWVUVMQ0hHcjJMN0NrUDBqSkpMdWpoYmJjVE44QTR5ZmU4Zm9NNm0vN3A2?=
 =?utf-8?B?bjhISTIyTVY4VUVTaFpoRWErTWtGOGs3NXZ2UVZjSWdMb2pFRk5NL2NjSmty?=
 =?utf-8?B?MDRWOEhNM0Z2ZGVXTXlkWnBUOENjekVQVEpKTS9vWjJFNEwrMy9adlJualQr?=
 =?utf-8?B?UlNuVTZLT1pzM2ZxZS9lTUd6TXp3TlBpbkczQytrVHduWXd1blpkNmNDc1Fz?=
 =?utf-8?B?YTVyYVhJVjlTcmFCeThYREJ4ZE9tZ3hEa044K2xxZzJjYmNJTG50NytBMXRB?=
 =?utf-8?B?cHZuZFpSc0dwcnkrQ0VlK2Z0OVZERG96T2ZMU3BzbUpxNEhzVGN3QkFXUUVJ?=
 =?utf-8?B?QlRrZFBIRlUwRTVHSjlQM3JUT3hvM2JJdFVLZERHZngwYUlDNVI5SWo0a3Q2?=
 =?utf-8?B?cHJ0QjNEanhQenlYeWZoOEx6S1BKM2F6cllTaVpiOWlBM2dnekRBVFJ6Qmoz?=
 =?utf-8?B?a3cyUSs3WEZMNzNMQkZFdXB2Z1d4dmZVVVp6TzBDTi9oS2UvTG5kYjl6ZFFL?=
 =?utf-8?B?T2grN25uMVdib3ZldnV0Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR10MB6535.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OU1XeHJsck5pNFhjV3NMU1dYVi9IL1dDYnF4eHVGVXZ0bWsrQ0JiNXpSYkxJ?=
 =?utf-8?B?ZXFQcVRFQUtoSUx1eFhHR1c5YldYczN0MExxeXErbEJSRTN4MVJ2QTUrVmcx?=
 =?utf-8?B?eVZFK0J3R1BBbXhNZFJieXFQT0xoM01yWGtxc0xCS1VkTC9mWEpwM1ZTRXla?=
 =?utf-8?B?eEI1YytWY0R0OEhoQklITFZzWFRZNk0rRkJWSHNMT0xoRFlJWDJ0ckZXVC8v?=
 =?utf-8?B?RWlrMFFHcGdndkZnbEI4dWRLTENtdXVYTDFRSkdId3p5eHYrVFByaTNpcXk4?=
 =?utf-8?B?OUNtdFJKUGt4SVdwS2R1OGhDUXpiYTJIY2hhSVBPRHlXQWp3WlZEb3NIWC80?=
 =?utf-8?B?OUlqWDVsQW9CYnNkTG9wYVFJYlBTV2tiek5KaWpkS3dCeUlSNDRQK1puQzh3?=
 =?utf-8?B?VkdMNmdlbDBvc1RJbHVsczFQdTVCUlVWLzUyY0wwaUlrNkMwK01VWmMyOG9r?=
 =?utf-8?B?NURBWGR0Y1lhOThEdDUxTVB6RjJ6OWkvczcvYUtxV3hWbVVZQVg1bys4emlH?=
 =?utf-8?B?SUk0UlZQdzNCeklBdm02M05yc3NjeGpQN3YzU0JmUGpnZ2x1bFhVUjJhK3Vh?=
 =?utf-8?B?UzRIKzhXMk1iNDBUT3p5OTM1ZElIa1Jhc0pPUmdyaGJJeVpQeS91K1Jrb000?=
 =?utf-8?B?SVNJQy8zWm9LN0xnMTlGck9uU2RpSGhzclo5UzFnVGxEMm83eVRpUzFNTExF?=
 =?utf-8?B?SytheHhDNnNBU2c5amNSaS9XakJEMzQwSXhTUDJHbklnUlN4OHplcFJNL0pQ?=
 =?utf-8?B?LysxQmJaMnBkQmliSTBRS25WQThLcmxmdkhocmVOVzhEWHZ3YXQyQjErR1E5?=
 =?utf-8?B?NmJpNGNXREJVUkorSFpFZG1PTUY0aEhnZHVocW9PRnRPOVVJNmVZdWNaYWYy?=
 =?utf-8?B?amxKQ3Z1elBsL08veUVSeEpxOUpMaExYRlBIZlQ1enpwcVdaSVRYMmJRNkY5?=
 =?utf-8?B?cTBldE5hWGMxd2ZJcXFLT1pyN1lIYW9iY1kzNFptdGtwSFcyRXYvNlV5OVNQ?=
 =?utf-8?B?QUdMalplTHlwcFRyV1g2UXgwL3BnREhLVm5WMHFWZEFNWHNOK1NQRkJVWE1E?=
 =?utf-8?B?SnJ0VGNtSVFUZzhRWWNneEpZUXkzUDR6KzVaNG53SFJPYW40MWNLU29sL1hC?=
 =?utf-8?B?Y21Cd3JENUswc2lYVDRkNFladTk4bWoyTzk1TkRjK1hlVmhZQUY0Qk9LZ2hB?=
 =?utf-8?B?NytVazZpWjJ1NVlZUWN1dlBRQVFwbDFtV2tnb0pSQlVPRjNmaW5kNWZiQVIz?=
 =?utf-8?B?QzRJZDMrbXludm9zUXRMcTh1N1h1QWc2UU1xakZrOVRZZUxPL2puNlNvRCth?=
 =?utf-8?B?TktyRHVycjhXeFk3Y1R2VHJLOFRBdkVXbXBBeHFsai9WSmhNTnh3Z0tkZWZw?=
 =?utf-8?B?akE1bHhOWHJyUVI4TXl0VEN6VnJvbnBUekZweTdKMkthWlRzZnZzVFVpa2hl?=
 =?utf-8?B?QnA1R3JweEFPWGNRKzcxcjUxRjliRTBKYU40alQ0T29ESHorQnJPU1JzaFJl?=
 =?utf-8?B?WU42V0YzUXo4d3hldklWSVJQTW9JZzRyWU1YeXBQOVNmdkxJcGpaVGdnL3la?=
 =?utf-8?B?eFZ5Rktxa2ZIV2pIWXdxZW1jVlREZXFKd1VvRDIzSlZpTVJxZWMrRTJxSFpK?=
 =?utf-8?B?U1lTZjBhcm51QkVXcExQd0R1d2ZXU1F6R2RLNkoydi9PR0xPWWc0QVN5Ulow?=
 =?utf-8?B?dUNoWGFKcEZsdWxZbXd2anVCT1pteDdjN0Q0Ujh6ME5iL0YxbUtGMkxobUxO?=
 =?utf-8?B?eW5Rb1NXN1o0T2JidEVnUkxGeG1aaE82b2xyQmRKcC9IOEZyUkU3SGhzRmc2?=
 =?utf-8?B?MlFFTis4S0pKUndkamttcURWUUU1SW4yVWhFUWN0SEIxSGlpSklMSHRMOGFJ?=
 =?utf-8?B?UGxqNlRob3BTYlh1Nis2VWFGRUJYaG9zcWNEekFSZW1SOFhnWU9ydmlGNkxi?=
 =?utf-8?B?ZFZpTEpvZy9vU3huWXBMK3BuaGFBSEpZeTRDVjZKREtCenhEa01TdkpwRkJy?=
 =?utf-8?B?a2JyZjdQSWcwajAxbERRZVJrOHRaUUROSjRqUk1aemFLcXAxWHF1VmtZdVZ2?=
 =?utf-8?B?MEdSdGgzV000RGJzUWQ1SnpqY0hjWmhVQ09ZbTZvVit1T1cxa2l4Q3gwU1lK?=
 =?utf-8?Q?NyPK3UsmDyCewUWWhshgdHOvd?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: vFRYSyuJwzia5zUUEObq8PuhDY4nUkQ/hdVkxixFLOB5fb8gOswihAjSOpH/eGNsDHUVTuFdfAnHw9KMyX0pXR7PfOQf0bfCHQc7YDdxHMPjDX8QQWP1zaIBETW0CgaMRGzoJ32qHDlwegyPM0Olw8HVm0ikbheUz5UhswaZhZa/WVgp1F3Y4PXkpssqO24n0/T7oTJR57nUZsUbTJsOeOyCb7opnXE5Csbk1Mllq3EsRX7R3dmxuEGDskKamR+yXK0U0DdsVXYprv+icuyVOzYRAagNhT8pWYNwt+BG0TioB3c6qEIbe/FyORp9rsQJteNEkTjpjNjbV1SsgFFBlrI4KrCS3DaCE7hcKMqKSNZVdRLlRRoYvuITJGdLQi7GVapi/1SlnHZRe+51S5UgyPm06WiJDLp+eN9ElWYu+8m7mBx03W9W7CltGiEqU+R5DeEyFl8SRLlihLIqjApXBISD4Mwsy3QGrEnaBjwZv8oeLCIPgeWcW1MUImvZ10UiJfRrCYxQDFfrk/lmjvUc/M78ZNASpExhoJ5Ta5eeEcJ6Ym293sfjlowxWuPamgOUJodUWHFls0aXi+BVbyF8V+vqhuIUvxeZ1AaRQjAxLrU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eea881e0-07d6-4384-671f-08dcb1c2b225
X-MS-Exchange-CrossTenant-AuthSource: MW4PR10MB6535.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 00:41:35.1856 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LL4OL+lw4LrIlYuBbtRc8SCDl9Zqk8uldxNwBxGHtMgS18yHYUDGItLDQ0VAaUahyZ7UncuA84qyvgVtRd13pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6821
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-31_11,2024-07-31_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408010000
X-Proofpoint-GUID: nf0JdVaxONT6DOt6LP5-idq3r1taNGj5
X-Proofpoint-ORIG-GUID: nf0JdVaxONT6DOt6LP5-idq3r1taNGj5
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=si-wei.liu@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hi Jonah,

On 7/31/2024 7:09 AM, Jonah Palmer wrote:
>
>>>>>>>>>> Let me clarify, correct me if I was wrong:
>>>>>>>>>>
>>>>>>>>>> 1) IOVA allocator is still implemented via a tree, we just 
>>>>>>>>>> don't need
>>>>>>>>>> to store how the IOVA is used
>>>>>>>>>> 2) A dedicated GPA -> IOVA tree, updated via listeners and is 
>>>>>>>>>> used in
>>>>>>>>>> the datapath SVQ translation
>>>>>>>>>> 3) A linear mapping or another SVQ -> IOVA tree used for SVQ
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> His solution is composed of three trees:
>>>>>>>>> 1) One for the IOVA allocations, so we know where to allocate 
>>>>>>>>> new ranges
>>>>>>>>> 2) One of the GPA -> SVQ IOVA translations.
>>>>>>>>> 3) Another one for SVQ vrings translations.
>>>>>>>>>
>>>>>
>>>
>
> For my understanding, say we have those 3 memory mappings:
>
> HVA                    GPA                IOVA
> ---------------------------------------------------
> Map
> (1) [0x7f7903e00000, 0x7f7983e00000)    [0x0, 0x80000000) [0x1000, 
> 0x80000000)
> (2) [0x7f7983e00000, 0x7f9903e00000)    [0x100000000, 0x2080000000) 
> [0x80001000, 0x2000001000)
> (3) [0x7f7903ea0000, 0x7f7903ec0000)    [0xfeda0000, 0xfedc0000) 
> [0x2000001000, 0x2000021000)
>
> And then say when we go to unmap (e.g. vhost_vdpa_svq_unmap_ring) 
> we're given an HVA of 0x7f7903eb0000, which fits in both the first and 
> third mappings.
>
> The correct one to remove here would be the third mapping, right? Not 
> only because the HVA range of the third mapping has a more "specific" 
> or "tighter" range fit given an HVA of 0x7f7903eb0000 (which, as I 
> understand, may not always be the case in other scenarios), but mainly 
> because the HVA->GPA translation would give GPA 0xfedb0000, which only 
> fits in the third mapping's GPA range. Am I understanding this correctly?
You're correct, we would still need a GPA -> IOVA tree for mapping and 
unmapping on guest mem. I've talked to Eugenio this morning and I think 
he is now aligned. Granted, this GPA tree is partial in IOVA space that 
doesn't contain ranges from host-only memory (e.g. backed by SVQ 
descriptors or buffers), we could create an API variant to 
vhost_iova_tree_map_alloc() and vhost_iova_tree_map_remove(), which not 
just adds IOVA -> HVA range to the HVA tree, but also manipulates the 
GPA tree to maintain guest memory mappings, i.e. only invoked from the 
memory listener ops. Such that this new API is distinguishable from the 
one in the SVQ mapping and unmapping path that only manipulates the HVA 
tree.

I think the only case that you may need to pay attention to in 
implementation is in the SVQ address translation path, where if you come 
to an HVA address for translation, you would need to tell apart which 
tree you'd have to look up - if this HVA is backed by guest mem you 
could use API qemu_ram_block_from_host() to infer the ram block then the 
GPA, so you end up doing a lookup on the GPA tree; or else the HVA may 
be from the SVQ mappings, where you'd have to search the HVA tree again 
to look for host-mem-only range before you can claim the HVA is a 
bogus/unmapped address... For now, this additional second lookup is 
sub-optimal but inadvitable, but I think both of us agreed that you 
could start to implement this version first, and look for future 
opportunity to optimize the lookup performance on top.

>
> ---
>
> In the case where the first mapping here is removed (GPA [0x0, 
> 0x80000000)), why do we use the word "reintroduce" here? As I 
> understand it, when we remove a mapping, we're essentially 
> invalidating the IOVA range associated with that mapping, right? In 
> other words, the IOVA ranges here don't overlap, so removing a mapping 
> where its HVA range overlaps another mapping's HVA range shouldn't 
> affect the other mapping since they have unique IOVA ranges. Is my 
> understanding correct here or am I probably missing something?
With the GPA tree I think this case should work fine. I've double 
checked the implementation of vhost-vdpa iotlb, and doesn't see a red 
flag there.

Thanks,
-Siwei


