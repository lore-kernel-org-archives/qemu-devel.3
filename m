Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F86DE7DEF0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 14:58:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmvNc-0000sU-RW; Mon, 02 Feb 2026 09:58:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1vmvNb-0000sD-7X
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 09:58:19 -0500
Received: from mail-southcentralusazon11012020.outbound.protection.outlook.com
 ([40.93.195.20] helo=SN4PR2101CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1vmvNX-0004tp-4U
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 09:58:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=txVAXo8C6fa5le36PwX29Xo7GSKvkdB3yfPolrQbutaodI+nH2jAPTJzUfmr/4TeW4uJrCinkaqnfR2BQIioBGJHsxkY61lBkD4ykJ3fVpVyGPideRBX9wa2dB2yJ72KAAIjUSZ1SmAMBuQngjsn9RZ3lsIib90teZRZhQA65i7XFzE64XfJjgYRNCVZoULdNS16hG1woY2kQKFzn2idzs6cqM5YyP68zdxIKthJA/iGolZ7Mz+A/SvM+ZJubf3NCZaA/Wm/KjI3rAFmvs5tHP/p20cU8CAUORSBizJNW8b3pzXBYTFjTpnfL8TXGob3+KHgWogifFn3zWluXsTA+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5sOFsnb8ckEAh3V3ifsdW4jHZ3/Z+qK7iA+VpfGCqgI=;
 b=wxaFDd+YnTHxxNCnEjAkwsFqn15EIXMYFSpC9v09LBGAK6zYPznT6HWIKV5uWgDsycpoRSaBmBGlr175CRax4u/OjvaaXUiuN3DPE/NtUu93W4u8KIIZp4oGiqdYJREn0zOHAHVqUfNpctINmf+CD6DASESbbbwGb633ctTCulwOpDGPdU81OwJG6MnnFbZww1OzgC+9fNgnd0487HNw1qkBin/ihjZght9phtjUbXXTKWjQS77A0Qb9vW7My7byICd1Y6MPJ7c5JO1hKCzU6wJxvA0uJqTaWksynQeBM0c74BZ0CcBef01mLXevWrMMzjcMQEUrwMlUb0VU9hTjSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sOFsnb8ckEAh3V3ifsdW4jHZ3/Z+qK7iA+VpfGCqgI=;
 b=ilovvu7vHK+1FXq9eJoaWXzVbF6OMAQscUtx1EHhAAlWX8p+Wy8f6NzjpOBwAQEAjMbt9/TYIIWof5PY0HX2cuzHFWVN/Llnjn9S5Nu5ZvDjnZSyjFcuo3da3/sdJB3ixEzha/T9v9nk/EXMxKmEFWnCN/e+2V/cAeaht+oTAra9shlLAdgE51oN7i+tmz/QON7f1nDiSOJq3hxV6BSK7doqgii2u3lgQUn4Dy3q7/i2gtf4TJ6jKmJYP+Ox9/bPLsPkT4J5ykY7NWV0hE/XPys/4UBEo0YAPhhRnWq6uA4ZaoLImL9ZnLnZN78GnVbYJC5QDshpTgNWrtp7vZkWYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5063.namprd12.prod.outlook.com (2603:10b6:208:31a::11)
 by DM4PR12MB7744.namprd12.prod.outlook.com (2603:10b6:8:100::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Mon, 2 Feb
 2026 14:53:07 +0000
Received: from BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da]) by BL1PR12MB5063.namprd12.prod.outlook.com
 ([fe80::a0c2:5681:4aca:90da%5]) with mapi id 15.20.9564.007; Mon, 2 Feb 2026
 14:53:07 +0000
Message-ID: <9f5eaacb-e99e-4d8b-888c-2191af1f09d9@nvidia.com>
Date: Mon, 2 Feb 2026 16:53:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vfio/migration: Send VFIO_MIGRATION event before
 PRE_COPY_P2P transition
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Maor Gottlieb <maorg@nvidia.com>
References: <20260201122348.28478-1-avihaih@nvidia.com>
 <0c48a2d5-776a-4cd7-a1ee-3cfc32dde931@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <0c48a2d5-776a-4cd7-a1ee-3cfc32dde931@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL0P290CA0009.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::6)
 To BL1PR12MB5063.namprd12.prod.outlook.com
 (2603:10b6:208:31a::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5063:EE_|DM4PR12MB7744:EE_
X-MS-Office365-Filtering-Correlation-Id: cf0df0ba-a192-43eb-c1a0-08de626ac694
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c1NZeC92WFNWMmM3VkwyVVFiMXRPeWdGYlFXVDlFSVgvVHI0cENjKzNWaTRn?=
 =?utf-8?B?RWNUcHNjSEE4cU1PN2VKaDVSKzRxTGhNSkFyMkZldkR0T3VveUxtY0p2V1lo?=
 =?utf-8?B?MzdvakRnMHZpeWdRTjZmNXhJT3RJUUJzQ0NsQnMvOVhmSjhTMHVrc0VLR1VV?=
 =?utf-8?B?dTVGaG1IS2IxbXNMVGh2UWNGT2VCK3BrbnZMYmZqNFJ1M1BaRUZlVmFBSmNI?=
 =?utf-8?B?VnlaazRBL3lOMUNqeTVPOFlwUDFqUzRweTEyaFNkV0RIVThrR1RMbnQ1aXRm?=
 =?utf-8?B?bFBZODdkeTVwNThWUUcwbXZ5b1NtOEE5Si9jWUZKcTBCSXkvdU1ONjU4WlBC?=
 =?utf-8?B?VWlLTlJDUEZSaitUbWlCWmpGUDhtM2FMR0p2VEVBVlQvZzBGOHVZL2wxdW55?=
 =?utf-8?B?TlVCeGI4QmNLa1BUNnJPeWNtWHFyVkZKVlFTdE9naVl4NHcxbG5Bb3lVUkFR?=
 =?utf-8?B?NDhpWFNFQkMrNjI4UTFWOFBSTWp0anY5SkJPSndEQW1zbHdpeGpWUVpqd0Ev?=
 =?utf-8?B?YVVYRzhoL2FYQnk2NnltTElUZGtsbUxHZ1ozUVV1TllTbUJxSWx3Ukw5OGJN?=
 =?utf-8?B?cDhmeENNRFlKY2h5UHkvRGZzNDZteDU3eFl4ZVNGbXpLaGJsSVVFcWptTXJE?=
 =?utf-8?B?WnYxUEtCSVdVcTVsT0ZaOUhpK2p2eDRzcytZajBnNmkwTjhaQnJNWmRMbVd4?=
 =?utf-8?B?cnFJaXFSL2dPTFZxY3lmTG9teWF2T2JoVGMzcHMzMTdUaFAwSlZUcW1RL1d2?=
 =?utf-8?B?a2ViWWR4MWJzZXRCUWx4YVpUS1JJWlNPYW40UTFDTWFHK3ZqUFJLVlc3YVp1?=
 =?utf-8?B?ZFJ1bEU0ZXJUUXRqZFFPakkwN0tTN0ViKzRYQ293U2srZlBjeEhQUW1seHhm?=
 =?utf-8?B?b3BmQStkc1RQU0JpZjRKZ1c5UTlaT0FzaXViVmZXV0xJbHRvN3lNU3UxSFRS?=
 =?utf-8?B?MWRIVm55aXFSZWVsLy9CQklZazFqYnptZWI5blk5bWtvRkgwOTVuYlVFMTRh?=
 =?utf-8?B?UWQ1R2p0d1B6c2RrL0VMVlRiY3NYQjMzaEV4TklZcVBQWmQ1N1prZHI5TTJF?=
 =?utf-8?B?WEpic3pMWUlvS0hiampER2VMK0VDSk9oTTBlUG16bTNZaTMwV29PVkhaQitn?=
 =?utf-8?B?ZU81cmpxYjFRU3Y5UEJOOUNiREoraUtwTWZIWG9hTVB1cWVodTdhNEw0SU05?=
 =?utf-8?B?Y0JLRURkV084YW1ueFAyQWo1c3puTTBqcFZicUNKQnZIQk5pT3ptdWlZT2Rk?=
 =?utf-8?B?SWdNRjNBTXhiN25OMURwWnV4cXg4RHduQXNCcDVGTGRmcjFSQW1ueUV6TE5y?=
 =?utf-8?B?YnUxQjNOckpFNFAzNEFaMVhLTXN6a0dFK3J1YmZ3eUVIVHRvYUF4RWhRNGlZ?=
 =?utf-8?B?elovTnQwYjBidVArT1dpVTR5NWdUMUdmRmJ3UjFWaGEvUWpzczlleTlybUhR?=
 =?utf-8?B?QkFyWmpvc29LNitadDh0TlR2OTJjNStxdTN4aW9SRTRpM1lBbTROUHUvT25O?=
 =?utf-8?B?TFZFRWNjQk51MHBKU2lpU1hkMXlCLzhSOThPdUxySWRhT2RMRkQrTXlzZlR3?=
 =?utf-8?B?RVR0T3U0aHVaZFpFQ3lqT2tzdUhFWm05NTlBeFQ0MCtYYTlxMnpBT3J6cE1x?=
 =?utf-8?B?Ti9uN3ZyTk5nSk5nYlhrQkcyVW1jWDlHL0VMcWF2SldrdDE2Lzh4YTVTYzNU?=
 =?utf-8?B?Rkt1SDVXTFpRZ2JPUlp5QUszRnpWeDJkZDJXRHkxUlA1NzBtaXI0K21pcHE5?=
 =?utf-8?B?MjQ0SHVjR3crdWZlOTFMV1dxK2thaEl6eXFIZFhnWGVWcW9ERWVNTi9BQ1FV?=
 =?utf-8?B?RnkxOEsvMkxZcXRoVGZjeCt5dHJBeCtaQmlnNUpjRkxMTUxXSDFERnIxUnlC?=
 =?utf-8?B?Uk5qeUloVWM2cCsybFZhcWJCMWNhWUwxWXp0OW1pVHhBZXQvRGxGSXJCbEFJ?=
 =?utf-8?B?ck9ZSkRzbmg4aWg2UkpwM3ZIZ2FnQklDU2ZlV0hDalllaDM5RldRVTdtWnN3?=
 =?utf-8?B?UnNqemZXUnhOVXJHUGlQUlJHL014ZXp1NlJNSkh3ZDArVGtLZnAxVHlqbzg4?=
 =?utf-8?B?WUtTVGVreWZwS01ja1JSTEwvQ0VJOWZrY1c0RHVUbmJDaTJ0YTl1VnU4MVVo?=
 =?utf-8?Q?CRM34hdLPYUQCI/7YwRx9Woiu?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5063.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RExHa0kwazFFREs0K2p0Yy9HcVV1ZXRIVUJaZXNLSkFXWGJ3cnpFMzFla2NI?=
 =?utf-8?B?NkQzSEZtakhjWUZ2bWYzUVNUYWZFajNHYVV3bTBlSnBMMjZrb1RJanF0WG5S?=
 =?utf-8?B?a0ZvL1E4NDZhazlMQkFBV1k3U0NxYlhSdC9RNVlZUWVBU0pSbnppU3NxSWFh?=
 =?utf-8?B?ODJwQkJJaFA2cUhtcEFmZldKQkZrTThYQkRCUWluMVpSdnhkVC9PUGM2cklI?=
 =?utf-8?B?QzNGSDBkM1hza21PU1lFUEtuanlpRjVQVHdwLytVUk5lU0l0WlhtZlliQU1r?=
 =?utf-8?B?cUg5cGlnb2xaRDc3VWlPSUV2QTYxcVhXbUpZbHlhdUpkTDRzdElWMWpBT3VM?=
 =?utf-8?B?dXVFdjlROU5kWHREY3RnK2VxcUViUjBEcGZuVWJwMFYwblk1dFdEUVp4cW8y?=
 =?utf-8?B?QjdLWk9FR3JUU2V6cG0zUS9ObTNPT25PWnNZK1pCVHU1blJFWGM5UDJiUDVr?=
 =?utf-8?B?eXJsR1NjMU82VDNTbXFjV2NoRS9FNVo5ZWFYcHlNOS9WZ2QwWjh0TGJ3NXhz?=
 =?utf-8?B?NERnbyt0ait3NG8ydDNVYTNHcHFLdVBHTWEzYVpsaEx4b1BncVQxQ0dkbUFR?=
 =?utf-8?B?VnRwdzFBN0ZtYUE3WnNTKzErR3RSMlVEOVp3ZmlXRGloODgvamJjaGxsVHVo?=
 =?utf-8?B?KzJwd3ZXcFN5ZzZnTkhid21xQmxzMlRqbjBwOFVIc1J0amF0aUZFQWM1aEd6?=
 =?utf-8?B?UEJBd0J1VHhXdjdWWlhqQ0FBUHNpT0tQazQ5V0lJNS9jbTZZeE04NE8vc0xZ?=
 =?utf-8?B?QmhSREpPRDZ5cVk0SmlFdnRJeVdOSHN0SktZSXk4bkhOK05NVlpHMDNsV3ZC?=
 =?utf-8?B?VDRaelRkZm1pdExPcE9Cb3gxajVBcVFjbTllS3dtckh5anowZm4yTklTeFU4?=
 =?utf-8?B?ejlyZ3p1US9PUGd0azY1R3FocnJLT2I3VGloYkl2eWw0TUhjUFluWVpTWWVY?=
 =?utf-8?B?bW8rMmdPcU5aYVNtMDdGM05US3dvWFcrRm4rR2JGWjh5dzQ1MUxTQk1nV2VD?=
 =?utf-8?B?QzRHNURQbUQ2U1dvc3FwRG5FRWo3cnJzUXZ3dzJWb0ovbnk1TTVEeGQyRXJh?=
 =?utf-8?B?VEJ1bFFJeldpRWY5bGJ4TmQvWSs5T1JGd01FQTB3Q0J0Sk04REZQUSs5TDZF?=
 =?utf-8?B?VGV4Y0YvZFl1aUZvVVhJOWV0c1ZBWUYzNzlHMStrdjAzYXpKektVSm9CVVh3?=
 =?utf-8?B?c2I5YklsOFE0eU5Hcm1mNk4yNXhNa0crVC80QkRkSTBWL2JjbnA2NTVRalVl?=
 =?utf-8?B?emJwMkZYRjQ0WTVXb1R3UExMK0lzR1RJQ3MzWFFsdTdtNUFkVld0dkdTSGIx?=
 =?utf-8?B?NWtweDZhWnpDVkk1ZjJyeEdzOG95THlNd3owdUUvRTExV3lUUklqMXU4U2dH?=
 =?utf-8?B?dXBmV2s3UU1YSGUrNzNzbEhINVNZVDdaNktRTXc1TDViYmEwdzE4OE9udG1y?=
 =?utf-8?B?MnlqT1BrOFBra1pVazdiTmtGM2hTMHh5a3k4MDV4OURNSm9IVEsweG45eFpV?=
 =?utf-8?B?a0lybXgwd1JENzN6Vk9jZEg4WEluZ2hMZkNrd2p4T3NNQ1BXYzFJK3BhenB0?=
 =?utf-8?B?U0RZNWVHWU15MUtCa0FtUXF3TmgxODB5T1pJK205bU5ZRTRLVmZtUnVEWDV2?=
 =?utf-8?B?TmhMa21yQnBxS3B2OVZ6NkxacHJ0a0RaMlVJV051SmlSUVRqY0FxNDExN2t2?=
 =?utf-8?B?cmFiT0ZzZHpDU0I4Zk1PdXJBenExa1RBTU9VYkhEWXkrczVhZUxRcmlYbWJv?=
 =?utf-8?B?YWFQc3Z1djNhYnBoL3pWdnhQalRWSXIwQzRNb3dYWEFwckpXYXpueWIyNk9w?=
 =?utf-8?B?MEpLVWw1cW8yWWxDMFQ0N2JJcHpPS0x0YXo5cWw0OHVRTHUzY0xnM2lScU5C?=
 =?utf-8?B?SzVOdkkvSE96bW0velU5UUphYWdCQ3RtK3htQ2NhekdLenZxTUJ1eGhDSjNJ?=
 =?utf-8?B?RDhjenlERGFNdjBOUm5qdWE0WGkvbFcreDFMRmRNY1ZvbjV3Vk9Uc001U2t5?=
 =?utf-8?B?SlVlUjhUNzA2OVNKNmFLYnhJd3Vkc25SQXZJamFFalJlak8yU3g0WjArYlNN?=
 =?utf-8?B?T1ZWRTVKYUtEVkk5TXhYUFIwdzdKZXk3dlFOb09OSXJPWVlOcWZ6OFNxc1pn?=
 =?utf-8?B?cW9DelZSdHhBRG15bnBiYURTdjNzN3pjT3Qxd1FHbHhCTk41N0YvTnNrUEZZ?=
 =?utf-8?B?cFpGRUFFaWxPN01iTkovRmkzMmF3R3hoRHNOR0Z3OS93QURVVGU4L0JZTWxT?=
 =?utf-8?B?SGxJZkRPSTFjTWIwOC9UZFIrb3dRTkhucnp2cjFCQ3hhVnh4UHJOdE9Mb1Bw?=
 =?utf-8?B?Z1ZYaUJsZ1JPMTlvM3NpWUJ2SzEwQnRlOWs0Rkc4K28zdVhhWU1JQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf0df0ba-a192-43eb-c1a0-08de626ac694
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5063.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2026 14:53:07.3278 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bwn/FIQTHuiBNmYgi1M/BPOoGyYU6F0AA8V5SYy4R4IORve8OWWif5rsJ5nl2K9928b60C27VtYTFAk2cdKH4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7744
Received-SPF: permerror client-ip=40.93.195.20;
 envelope-from=avihaih@nvidia.com;
 helo=SN4PR2101CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 2/2/2026 3:33 PM, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> Hello Avihai,
>
> On 2/1/26 13:23, Avihai Horon wrote:
>> The VFIO_MIGRATION event notifies users when a VFIO device transitions
>> to a new state.
>>
>> One use case for this event is to prevent timeouts for RDMA connections
>> to the migrated device. In this case, an external management application
>> (not libvirt) consumes the events and disables the RDMA timeout
>> mechanism when receiving the event for PRE_COPY_P2P state, which
>> indicates that the device is non-responsive.
>>
>> This is essential because RDMA connections typically have very low
>> timeouts (tens of milliseconds), which can be far below migration
>> downtime.
>>
>> However, under heavy resource utilization, the device transition to
>> PRE_COPY_P2P can take hundreds of milliseconds to complete. Since the
>> VFIO_MIGRATION event is currently sent only after the transition
>> completes, it arrives too late, after RDMA connections have already
>> timed out.
>>
>> To address this, send an additional "prepare" event immediately before
>> initiating the PRE_COPY_P2P transition. This guarantees timely event
>> delivery regardless of how long the actual state transition takes.
>>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> ---
>> Changes from v1 
>> (https://lore.kernel.org/qemu-devel/20260128105159.10282-1-avihaih@nvidia.com/):
>> * Removed VFIO_MIGRATION_PREPARE event and instead added a new
>>    PREPARE_PRE_COPY_P2P state which is sent before PRE_COPY_P2P
>>    transition
>> * Added details to commit message
>> ---
>>   qapi/vfio.json      | 13 +++++++++++--
>>   hw/vfio/migration.c | 20 +++++++++++++-------
>>   2 files changed, 24 insertions(+), 9 deletions(-)
>>
>> diff --git a/qapi/vfio.json b/qapi/vfio.json
>> index a1a9c5b673..2de87dc215 100644
>> --- a/qapi/vfio.json
>> +++ b/qapi/vfio.json
>> @@ -11,7 +11,13 @@
>>   ##
>>   # @QapiVfioMigrationState:
>>   #
>> -# An enumeration of the VFIO device migration states.
>> +# An enumeration of the VFIO device migration states.  In addition to
>> +# the regular states, there are prepare states (with 'prepare' prefix)
>> +# which indicate that the device is just about to transition to the
>> +# corresponding state.  Note that seeing a prepare state for state X
>> +# doesn't guarantee that the next state will be X, as the state
>> +# transition can fail and the device may transition to a different
>> +# state instead.
>>   #
>>   # @stop: The device is stopped.
>>   #
>> @@ -32,11 +38,14 @@
>>   #     tracking its internal state and its internal state is available
>>   #     for reading.
>>   #
>> +# @prepare-pre-copy-p2p: The device is just about to move to
>
> Could you please rename to "pre-copy-p2p-prepare" ?

Ack.

>
> Peter, Fabiano,
>
> Any preferences in the naming ? I would like to avoid
> "pre-pre-copy-p2p" but it is what this event looks like.
>
>
>> +#     pre-copy-p2p state.  (since 11.0)
>> +#
>>   # Since: 9.1
>>   ##
>>   { 'enum': 'QapiVfioMigrationState',
>>     'data': [ 'stop', 'running', 'stop-copy', 'resuming', 'running-p2p',
>> -            'pre-copy', 'pre-copy-p2p' ] }
>> +            'pre-copy', 'pre-copy-p2p', 'prepare-pre-copy-p2p' ] }
>>
>>   ##
>>   # @VFIO_MIGRATION:
>> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
>> index b4695030c7..3b215eb4ff 100644
>> --- a/hw/vfio/migration.c
>> +++ b/hw/vfio/migration.c
>> @@ -68,7 +68,7 @@ static const char *mig_state_to_str(enum 
>> vfio_device_mig_state state)
>>   }
>>
>>   static QapiVfioMigrationState
>> -mig_state_to_qapi_state(enum vfio_device_mig_state state)
>> +mig_state_to_qapi_state(enum vfio_device_mig_state state, bool prep)
>>   {
>>       switch (state) {
>>       case VFIO_DEVICE_STATE_STOP:
>> @@ -84,15 +84,17 @@ mig_state_to_qapi_state(enum 
>> vfio_device_mig_state state)
>>       case VFIO_DEVICE_STATE_PRE_COPY:
>>           return QAPI_VFIO_MIGRATION_STATE_PRE_COPY;
>>       case VFIO_DEVICE_STATE_PRE_COPY_P2P:
>> -        return QAPI_VFIO_MIGRATION_STATE_PRE_COPY_P2P;
>> +        return prep ? QAPI_VFIO_MIGRATION_STATE_PREPARE_PRE_COPY_P2P :
>> +                      QAPI_VFIO_MIGRATION_STATE_PRE_COPY_P2P;
>>       default:
>>           g_assert_not_reached();
>>       }
>>   }
>>
>> -static void vfio_migration_send_event(VFIODevice *vbasedev)
>> +static void vfio_migration_send_event(VFIODevice *vbasedev,
>> +                                      enum vfio_device_mig_state state,
>> +                                      bool prep)
>
> prep -> prepare

Ack.

>
>>   {
>> -    VFIOMigration *migration = vbasedev->migration;
>>       DeviceState *dev = vbasedev->dev;
>>       g_autofree char *qom_path = NULL;
>>       Object *obj;
>> @@ -106,8 +108,8 @@ static void vfio_migration_send_event(VFIODevice 
>> *vbasedev)
>>       g_assert(obj);
>>       qom_path = object_get_canonical_path(obj);
>>
>> -    qapi_event_send_vfio_migration(
>> -        dev->id, qom_path, 
>> mig_state_to_qapi_state(migration->device_state));
>> +    qapi_event_send_vfio_migration(dev->id, qom_path,
>> + mig_state_to_qapi_state(state, prep));
>>   }
>>
>>   static void vfio_migration_set_device_state(VFIODevice *vbasedev,
>> @@ -119,7 +121,7 @@ static void 
>> vfio_migration_set_device_state(VFIODevice *vbasedev,
>> mig_state_to_str(state));
>>
>>       migration->device_state = state;
>> -    vfio_migration_send_event(vbasedev);
>> +    vfio_migration_send_event(vbasedev, state, false);
>>   }
>>
>>   int vfio_migration_set_state(VFIODevice *vbasedev,
>> @@ -146,6 +148,10 @@ int vfio_migration_set_state(VFIODevice *vbasedev,
>>           return 0;
>>       }
>>
>
> A short comment (extracted from the commit log) here would be good.

Ack.

>
>
>> +    if (new_state == VFIO_DEVICE_STATE_PRE_COPY_P2P) {
>> +        vfio_migration_send_event(vbasedev, new_state, true);
>
> Please be explicit :
>            vfio_migration_send_event(vbasedev, 
> VFIO_DEVICE_STATE_PRE_COPY_P2P, true);

Ack.

Thanks.


