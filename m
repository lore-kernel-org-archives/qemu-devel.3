Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8CD0C19F32
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Mar 2025 14:53:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tokgw-0001s0-00; Sun, 02 Mar 2025 09:53:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tokgu-0001q6-Tb
 for qemu-devel@nongnu.org; Sun, 02 Mar 2025 09:53:16 -0500
Received: from mail-dm6nam11on20605.outbound.protection.outlook.com
 ([2a01:111:f403:2415::605]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tokgs-0004Oy-Qz
 for qemu-devel@nongnu.org; Sun, 02 Mar 2025 09:53:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TMXlPTISn5bNKvC7zC6NyxWVNDo+C8KTnnCyoywUvVjeUc2V8tiyPO+B032x+e09atDjCtKG6w56d8gUV8Inwj3z9Nine/YpapH4RTiPdQ+QcTCiSsadfZWCh1x/gWRt+SlDfAZnY4DJJVisrB0lnu/DP6fMkxOTOzEMErl1ZsnVcgWFB9iB+4FbNZMouzxfuShFA6vmPgjkpti1wdbqo5H4T5z/vnDoMuGJ772cJM+NPx2sbsBw7NGWVaoeRXeBKr7pWYEHWV45nOE8+tO1U6vWA/E0jxQJKVMyhCFgmFkUN4apmoma0LUih7zhesmeO0Gt1U3XejwTjsq5N+lMMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pdnrYKcyLqMouonJl7sl2kc1yedVgYZQSWmNDH/o5tA=;
 b=oGcIM6RZ+0gZVzY96xC/MqQx8nsDoYe1n/4PBHRzGwQR5CNz+BV7+8PJ8Ubj93snpG5vHDNnzw2Pdy0N9kVwUu6FggHBaBQ0UTLL7Wbkd0vkQhvb8B8t/qcSmmTizUYM0rjkf06rSJZuae+eI9bNYdCcFsSN5l6Ge2Xd1/R4PB6gXf+HsjEsKPnAaJYikKG/1u0pP+JMZwmB4at2D5x9BUt+Z3iAihKcrBgo0voHojmY21qP7OVf2vopiTY/HyDE9RVBFCGbFB87QvHxDXGCrwrwtVUJRij5l1EJQ+7jaUe+QaFTM3pGCcBDe1YuR8+HvdsewPUlO7GfRu0KIyjiMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdnrYKcyLqMouonJl7sl2kc1yedVgYZQSWmNDH/o5tA=;
 b=WjSFbtX98QhZ/VoY0fAed6/rPyao9UbAosKD8mghz0Kb2KaqkNz7DfHrpTkOrvj7Of09G9PhPMGBWytaFRYwUX2YrLT87SrvE+SEkMEmDP+Kp2JW+6TfoqFY3ASX++lSluajDdwBAIJJrghAfFUdXtW+oJ+EdBlwFp20KDwiyY9qmI7osjDG6cL0yBGKmnw6xUGud0D0MVxtGJdSjWlI28AY8mjCj4jW0Z3jPl+UqVQ6UeLWE62Y27yR46H44RE+nfgpDMrurfIf13XV77bM0v2yl8I8ZadLrL2+3ZZpdIEFbm4y/JNC2i9B9nDn/L/xa6TQUJugBiuXg7mnTgE1ZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by PH7PR12MB7139.namprd12.prod.outlook.com (2603:10b6:510:1ef::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Sun, 2 Mar
 2025 14:53:08 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%6]) with mapi id 15.20.8489.025; Sun, 2 Mar 2025
 14:53:08 +0000
Message-ID: <d7a7c7ee-5529-4091-a241-6cdde9943a25@nvidia.com>
Date: Sun, 2 Mar 2025 16:53:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 34/36] vfio/migration: Max in-flight VFIO device state
 buffer count limit
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1739994627.git.maciej.szmigiero@oracle.com>
 <719b309bb7bc13542d14e6ce0026cb9bb67e9f31.1739994627.git.maciej.szmigiero@oracle.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <719b309bb7bc13542d14e6ce0026cb9bb67e9f31.1739994627.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0461.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::16) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|PH7PR12MB7139:EE_
X-MS-Office365-Filtering-Correlation-Id: 20fa8c4b-27ae-4338-8448-08dd5999f1e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TDJqSnEwakI5Vnk1MWtMR1lhQWRUS2k5d1pnK1BPK3h5U0wwS05zRHNrN0Zz?=
 =?utf-8?B?VkY2WS9IR010VGZZeU9FM2hQdDliZG50NFNsTjFZTDFHcVNNczFna3FwTkJy?=
 =?utf-8?B?bW5sNjJiWS9EVWlKU29IelBGS1ppS0xXY080d1VoUkk4QXZaTko1b0VNMjB4?=
 =?utf-8?B?UjFPSFdsZFlGOTN5TkpBQUhjZkY4TDY3M3lXbWxZdTIxUzhuN0JBc1pyd3Nj?=
 =?utf-8?B?b1ZqUThQdzdYbjJCOTZoQmRZWUNsK1dCeXc3RUpTemVqajFEemw0Vko3QXpZ?=
 =?utf-8?B?c1U2eGdJQ3dxeVJUSTFDNzR5SzQ3TWxzSjF1TkhTeXpiNVFxdTlxWXFUZ1Z4?=
 =?utf-8?B?WEZVeGlxZXp6aHFWT1NZWmlwNXhwZHNaQWtKaTNtRFNQSHJtZWRpVlBmMEMy?=
 =?utf-8?B?eU9SVEJQV25XZTQ2S1daMGx5cmdQSDlSUGVUU25id2k3bXVUcnkwVEt4Y3F5?=
 =?utf-8?B?MDJ0RUFDa3lENVdFOVJHZEIyZDNiNlE4bUUwMG00czJKVCs3dU90aTFRTlJQ?=
 =?utf-8?B?Ykx5RUQ0YTJ4SVBWc3FnempWRXZGKzhaaHZWc3FLV2orRzNJY3c5QzJrL2Nh?=
 =?utf-8?B?MlRNbkRsVGlianVYNTlQN2lWRVVNQ3VEb0swYTErb2crSTNlQXRObFNIdERu?=
 =?utf-8?B?YXgyRmpDL3RQSDYwMVpPNFBWTWJXODlndmlmd280MnVEVjVJbnNJczlpUXl1?=
 =?utf-8?B?WlMyZHFST2N6T1Y3a1dMMGI1N2ZpbVpUdnBQUFkwU2NNekhxRnFhMms1MnRv?=
 =?utf-8?B?T05EbytMZjNJa3pZUzlncklSVkkzY3E3RVBISnNDZTM4SVhRcUl1RjRvc0ty?=
 =?utf-8?B?OXpVM094QU5kQTJaQWNGWU1lTENZV1I1SUdacTVObVFkb0pFeFBSZmRwRHJS?=
 =?utf-8?B?UENwTjlIbnlnaWtMbnh4Zk5lbkhKV1JWQlduTXV4eUc5Q3hpcllIK1A3RVhN?=
 =?utf-8?B?SXozdnFNQmphemZoWWtidUlPRHU1enlhVmdMVUt2dldnMmMzeUo1OFFJZkNF?=
 =?utf-8?B?ODI3TU9kbjhjaGhBK3pTdkZZTnB4aXBIWVd1NHdTWGdXZ0cyUkhyc1pUa3oz?=
 =?utf-8?B?SVRRbm5CWHBZcUJVNUo1MFBDdmpKWWJveVZmRlpveGRSY2xqN01iV2N6b3d0?=
 =?utf-8?B?Q1hGMUlQUmg2RDZ1cW53T28ySEtFQm1oSi9VekhzUVBTa2xMY25KY3Uyd0Zj?=
 =?utf-8?B?YlMxdVZ2azN1UDFZYy9FRXFyYm5LOHJmUE5IaVdScnBscFpidWo5THpndG8x?=
 =?utf-8?B?YkttS2FHVnFubytmL28vblVob1ZBK2JjRjBPM1BsKzRVcHJZckQxcTBxb1dh?=
 =?utf-8?B?eUlnYWdscVZtQ1JnMFdUd29BcDdnVUNwR0ZSUU1nVzlLckpmK2lRWkgrRWQ0?=
 =?utf-8?B?ckpmSnIzTUpjWVRUV0VkL1NCU3ozdE9mMDh5VXBjSGVKZEpZaHY2ZUttM1Vq?=
 =?utf-8?B?bXFPeC9OWWtSdUEweDlKamhzY29FYzdDbVBQeWhPR00yOVBubWxwNGlLenR3?=
 =?utf-8?B?TW00VUtrRUhFMXlmQzI0cnJaUk9lczdMWnpwa1NWNTJTQWF4cHJ2bFM3SklI?=
 =?utf-8?B?MDlhZDF1c0hva1k3VGlCbHRhZFdCaUVEejF6TXJicHREb3hmb3drWWx0MDFX?=
 =?utf-8?B?NVRjVmhwWjlqWkJqQkM5NTUzRE5CQ28vWXZCQWlkcTl4S3BqZ0RYYnVmR1Rw?=
 =?utf-8?B?M3Y2d0JwQmNxQzZGSitEYzZjQWJWL0tLNWEvMGs4VXRhQVRTNXBsK01zVFN2?=
 =?utf-8?B?bXNGaG5wc241Ym0xdTNkNlphcS9hQ1NsY3BlM1hQckt0UnZ4dkNSSUZwT0RE?=
 =?utf-8?B?anBnOG03WlFiU2doS2RDNFF1YjllcVhrczNjMnpHZGNZRWd6Yjh5WUtqZ2lv?=
 =?utf-8?Q?5L1rcIaZT0PJe?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFJDQmhHNjR6a2xIaHRaQ3FyYU8vd2s2aHo1Y2VFRmRJajBxcGpaakNwMXFT?=
 =?utf-8?B?UFNjcms2akxGWVNBOHcybmN5WFBKNnExNVFma0R5WjFiL1JoZERKdzlPRUti?=
 =?utf-8?B?QUp5MHpLeDFlb2xkYk8wcE8yZGk1dUdLTWt0RkJQNkJVU0c3bDJFZGs2Uk1Z?=
 =?utf-8?B?SlJ3Nnk5YjU4cWhuZmtPWmwvZUZKOU0wRFNlUUthSWNEWEgzdjVZOWJyaVps?=
 =?utf-8?B?VFJMMmRDZDczNjRMeWlmMG9BOXo5c0s2MDBsMWZGTG1VbCtOcmR3dW9yN2c0?=
 =?utf-8?B?NHFyM3FwSC9zVkM3bG8zTktIQWpFL01uZkY5N2piNGJrRFd5WTcrWmtub0JZ?=
 =?utf-8?B?VTVkN3ovQjdMY0Q4aS9ZVVdEZWoxWW05dmRTVkJydDhvVW4zMk5yWWZQQ0Q2?=
 =?utf-8?B?VDFQOVBTVFZqVEtzd2JYcUxPNlhPaXV2aWdFalFCQ1NEL3JwZVJJRUVFclUx?=
 =?utf-8?B?VGJHTDNKWTBqbXQxVVNqZHVUVjE5VG90SEFBdXJZbUthZTlYSEFsLzUvZmlS?=
 =?utf-8?B?UytoUlhPd1JMMHJjM25sUyt0QmNkekYvS3gwQ3B3ZkszQ0plNnlzSDNOeGdw?=
 =?utf-8?B?SG1JWFprUHRjL0l6TCtGclEvRk5zWURiV2UrOW1oK3lnM2J3RXBUekJPQ2Z3?=
 =?utf-8?B?dTN5ZWxyU2lnL25id0tsQjlOQVl0ZXZZK1kyQ0ljc296YktRbkplUG9ndHZu?=
 =?utf-8?B?REQzSlBxbGZwTTFCSFpCZVR2MjJLVUgwTDRSYlNEOHduWDhvUzExd1Ewbkxj?=
 =?utf-8?B?eDU4NzE2OFNkdlIyL1dxc0tYK2Jqb1NxeTlYYlp5Yi9zVjVrSjhreGV6akVs?=
 =?utf-8?B?ZUJwQjk4ajEzcFVVYnJVZjRBWWtPcjJPUi95NVBRVkRDQWxSWlQ0UWU4Q1p3?=
 =?utf-8?B?eUI4ME5wM1RpalEzMCtiVjY2S3k4MkRhdTFYM3NVc2ZnUktkMk5OSkxPQ0Yz?=
 =?utf-8?B?ZGFtdUYxT1FPTzZic0tYWHZ1K2NwN3RUTFBucXRyT3RoQVBNRjEvNHBqdzdW?=
 =?utf-8?B?aWRZc2F5dEdQRFJGL0pRMjlDK0N3N2t0OTcvVGZLKzRCVWI4ZlZGWGpBMGN0?=
 =?utf-8?B?VnQxNC9NSEw4ZkJsUWFxbE5udTQ1MXRoWlhlQm1yRzJ0YS9MNTl4QjRuMHhN?=
 =?utf-8?B?cVZUcWwzN2NjU3VDUnloelJweGswaTlZSlJjUzV1TjNzOU9UOFNkOFF0aHow?=
 =?utf-8?B?WEJMNkxhZnN1eHFGWEpFUHA4QTc4SkZpV29tajl3RFkxN20xYkNtVlcyQ3hZ?=
 =?utf-8?B?NUhHVjgwTXJ0SDBUVXh4U1dZVEwzNzRYT2c3V0dsSTFreVZITklzT3lRdy9w?=
 =?utf-8?B?ZjZnVk02QTZVNS9SMUkya0UzWE5YMzlqNG5TdGc3YzBQYnEzN3RqRVhpbEwx?=
 =?utf-8?B?MnZGVERTZEJmbHIySmd6QllzQVRaVHBWdEllRkRrNXdEd1VtZUlrZnppRWZ1?=
 =?utf-8?B?NWpoMlYrVWxWQkVkZE9TT3A3ZDR1K3d1WHAyZ1FJM2krNEloSlhPM1hDczMv?=
 =?utf-8?B?WkV5RHZUMlR6Z283QnpLWlBtUGRvT1dXYWxqNERLMEJvVGhJV1MzbVJsdmZG?=
 =?utf-8?B?YzRtdExFZFh6YWlUZnMxVVhGemx5RFJtbkZVSDVhT1hBMk95Um5UY2FEaXRS?=
 =?utf-8?B?a2VGbkxxRU01MDlWb0N1VWVGWXN1cCsraUo4alJDeVBoMVV4TndUWk9KUE54?=
 =?utf-8?B?Zzhtdm9PUEYxSytCeXdNQmJwVG1YSktnODF6MUl6RC9pMjBlb3BBSmdWZGw4?=
 =?utf-8?B?UTY3V2g0aFFzRUlIdEVLVjJpZnlWM1dIS2V6VnhwZ3RpLzJLenBRZ2VvdDh5?=
 =?utf-8?B?d0gzWUFrNUVVQ29qVnI0OW0ybGxsZloxVkhoRFI0Q2V0b1JMbzdKanRtZlZm?=
 =?utf-8?B?S0hFQkgwZUhnVzNCRkNIamVWZ2RWbDVrTEJTZUlJd0FISHJRbUlmRWlSUnAz?=
 =?utf-8?B?SFoyUG5tdTc3eVlaME1nUUtwbHdZeGprdUpyT2M4WTNpbHAvVXp3Wnd2T2RG?=
 =?utf-8?B?V29UaFFWQksrTG0xRGNIMFYxRWE3eGlKVUtBcndEZnNiODNlWUlWaDVKNVNx?=
 =?utf-8?B?Y1FZc2JaT0RkRnprMW9zR1U5TzYrbDRuVFgyS0ovS2lvZkl3ZzJxeGFRbGRJ?=
 =?utf-8?Q?UGqaIseosvlgRuP14L58la8EK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20fa8c4b-27ae-4338-8448-08dd5999f1e1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2025 14:53:08.1897 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N9+H0F8MqM/GozRuCbZfYfGVyq0zTxCc+JEcIs260kV7piVeUG+mGSp3QrSAjDCOiWQ41XP/Epmv7k7AsgDt1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7139
Received-SPF: softfail client-ip=2a01:111:f403:2415::605;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 19/02/2025 22:34, Maciej S. Szmigiero wrote:
> External email: Use caution opening links or attachments
>
>
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>
> Allow capping the maximum count of in-flight VFIO device state buffers
> queued at the destination, otherwise a malicious QEMU source could
> theoretically cause the target QEMU to allocate unlimited amounts of memory
> for buffers-in-flight.

I still think it's better to limit the number of bytes rather than 
number of buffers:
1. To the average user the number of buffers doesn't really mean 
anything. They have to open the code and see what is the size of a 
single buffer and then choose their value.
2. Currently VFIO migration buffer size is 1MB. If later it's changed to 
2MB for example, users will have to adjust their configuration 
accordingly. With number of bytes, the configuration remains the same no 
matter what is the VFIO migration buffer size.

>
> Since this is not expected to be a realistic threat in most of VFIO live
> migration use cases and the right value depends on the particular setup
> disable the limit by default by setting it to UINT64_MAX.
>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   hw/vfio/migration-multifd.c   | 14 ++++++++++++++
>   hw/vfio/pci.c                 |  2 ++
>   include/hw/vfio/vfio-common.h |  1 +
>   3 files changed, 17 insertions(+)
>
> diff --git a/hw/vfio/migration-multifd.c b/hw/vfio/migration-multifd.c
> index 18a5ff964a37..04aa3f4a6596 100644
> --- a/hw/vfio/migration-multifd.c
> +++ b/hw/vfio/migration-multifd.c
> @@ -53,6 +53,7 @@ typedef struct VFIOMultifd {
>       QemuMutex load_bufs_mutex; /* Lock order: this lock -> BQL */
>       uint32_t load_buf_idx;
>       uint32_t load_buf_idx_last;
> +    uint32_t load_buf_queued_pending_buffers;
>   } VFIOMultifd;
>
>   static void vfio_state_buffer_clear(gpointer data)
> @@ -121,6 +122,15 @@ static bool vfio_load_state_buffer_insert(VFIODevice *vbasedev,
>
>       assert(packet->idx >= multifd->load_buf_idx);
>
> +    multifd->load_buf_queued_pending_buffers++;
> +    if (multifd->load_buf_queued_pending_buffers >
> +        vbasedev->migration_max_queued_buffers) {
> +        error_setg(errp,
> +                   "queuing state buffer %" PRIu32 " would exceed the max of %" PRIu64,
> +                   packet->idx, vbasedev->migration_max_queued_buffers);

Let's add vbasedev->name to the error message so we know which device 
caused the error.

Thanks.

> +        return false;
> +    }
> +
>       lb->data = g_memdup2(&packet->data, packet_total_size - sizeof(*packet));
>       lb->len = packet_total_size - sizeof(*packet);
>       lb->is_present = true;
> @@ -374,6 +384,9 @@ static bool vfio_load_bufs_thread(void *opaque, bool *should_quit, Error **errp)
>               goto ret_signal;
>           }
>
> +        assert(multifd->load_buf_queued_pending_buffers > 0);
> +        multifd->load_buf_queued_pending_buffers--;
> +
>           if (multifd->load_buf_idx == multifd->load_buf_idx_last - 1) {
>               trace_vfio_load_state_device_buffer_end(vbasedev->name);
>           }
> @@ -408,6 +421,7 @@ VFIOMultifd *vfio_multifd_new(void)
>
>       multifd->load_buf_idx = 0;
>       multifd->load_buf_idx_last = UINT32_MAX;
> +    multifd->load_buf_queued_pending_buffers = 0;
>       qemu_cond_init(&multifd->load_bufs_buffer_ready_cond);
>
>       multifd->load_bufs_thread_running = false;
> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> index 9111805ae06c..247418f0fce2 100644
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
> @@ -3383,6 +3383,8 @@ static const Property vfio_pci_dev_properties[] = {
>                   vbasedev.migration_multifd_transfer,
>                   qdev_prop_on_off_auto_mutable, OnOffAuto,
>                   .set_default = true, .defval.i = ON_OFF_AUTO_AUTO),
> +    DEFINE_PROP_UINT64("x-migration-max-queued-buffers", VFIOPCIDevice,
> +                       vbasedev.migration_max_queued_buffers, UINT64_MAX),
>       DEFINE_PROP_BOOL("migration-events", VFIOPCIDevice,
>                        vbasedev.migration_events, false),
>       DEFINE_PROP_BOOL("x-no-mmap", VFIOPCIDevice, vbasedev.no_mmap, false),
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index 3006931accf6..30a5bb9af61b 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -155,6 +155,7 @@ typedef struct VFIODevice {
>       bool ram_block_discard_allowed;
>       OnOffAuto enable_migration;
>       OnOffAuto migration_multifd_transfer;
> +    uint64_t migration_max_queued_buffers;
>       bool migration_events;
>       VFIODeviceOps *ops;
>       unsigned int num_irqs;

