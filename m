Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55655C19F32
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Mar 2025 12:48:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toij8-000142-GV; Sun, 02 Mar 2025 07:47:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1toij2-00012n-Tl
 for qemu-devel@nongnu.org; Sun, 02 Mar 2025 07:47:21 -0500
Received: from mail-bn8nam11on20625.outbound.protection.outlook.com
 ([2a01:111:f403:2414::625]
 helo=NAM11-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1toiiz-0001C4-TP
 for qemu-devel@nongnu.org; Sun, 02 Mar 2025 07:47:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GFbw2hFxo83ORt4HoQ+bzQYJguzNyTDnWyNgY+amPeXs7kjYu5Jy6ltZ7f4WlTT/Hji2D95dISvAxpzA1589etJa5xtKbYgB1jZfla8IqDSwshEcSAQ+CsI7pFwH8ID8Jw2P0ID35lhNqKrwWejUkRMIZ+bECzvtDAIU6qFYa2SKDXxM/3P5vcQo1t6e4Xa0lscv/qpbePEvXw3kRKr6y2+fBwYGgOi3Pg/OJwwHMWvjVF+ikZxpK10t/LP4hB/C7I0vgMWu0ktpm9oSDIVlIY0Qfheshifq0BLGQfqSiI90DS7IEp6aUfTiFeygiYH3gRCiljCdts0XerR1kcDRKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BrzQ9ft5iddhJZCnmTe2xtTpimu0E7b/E9BCBwBEz7Y=;
 b=xiYw1hq9Rb235OzaIHKroUt5rjigTflSQGJZz93UxMEDJsI82S9CMB7t93XQLmx+n3ZRzQW5FNRelRE8cX4EUpJyyI41Yj3RxSrtK5gQDaHywoviicrO5xBq51T2LiZfB7gHKHglhAWW/n6QBlJEG4mYSNM1uKMy9dEL5WPPMrwYGE8FfYu7gchhC0dKfiQRirFzMtbLiMQgmQRfeQqkHEy+2O/JPZrbsoHA+VOA8+2kBVnfc+qEip5nO0Ck3wl0E0SdnFqAZgOMghw4ezdY6MMHtoC6bvdqAXIX48/Td3ZQLg0SA3115rX4UX9GRLxPl9v4JLnQ1zxCOqj01tcBBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BrzQ9ft5iddhJZCnmTe2xtTpimu0E7b/E9BCBwBEz7Y=;
 b=EK9UfFHxfdXNYtTDF0DCnahbh2IEh03leAFBdkGEyfPnsX6HZRpGuG2+I3dC0KZ7lezrmxxMQ8wiZCr84RjlWTmrz9PefNwLz08sInkpMD9om7ea0nR0kT48Qzs9p6GiS6B4FlJXBNhvv66MZ6KY7w9iQ8zog9g/hhb/RmvoNxKGKfG/AScOc2iKl4jbOY7e4OUPBnv6M69MzUxlv9Kzo4QXXFFj7xEwZBFRZE790LXf5paG+G/L0pZsNd2er4IB/CESUQKWTLcOZk3LpGcm/NA/JvNrFuupdRZV98PUhwn0+6KwE+Ib2u78sSEPNXlHr4lupvdqvpbHS27awSQW7w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by IA1PR12MB7662.namprd12.prod.outlook.com (2603:10b6:208:425::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.21; Sun, 2 Mar
 2025 12:46:41 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%6]) with mapi id 15.20.8489.025; Sun, 2 Mar 2025
 12:46:41 +0000
Message-ID: <d446584d-b22b-43f0-99c6-dd6a2fb58670@nvidia.com>
Date: Sun, 2 Mar 2025 14:46:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 14/36] migration/multifd: Device state transfer support
 - send side
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
References: <cover.1739994627.git.maciej.szmigiero@oracle.com>
 <b7ab14bee598eef62940a8833455126e62a91c0c.1739994627.git.maciej.szmigiero@oracle.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <b7ab14bee598eef62940a8833455126e62a91c0c.1739994627.git.maciej.szmigiero@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0413.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::14) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|IA1PR12MB7662:EE_
X-MS-Office365-Filtering-Correlation-Id: de7db5b8-a0f8-4462-7a99-08dd5988478b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TVRmai81Zm1qMk9vWUNPRC9hWCtBcG4yWC9BcDlTQ1g1TnNvbGs1RWEyOUJh?=
 =?utf-8?B?bDNCOHNDZklGNkgvYVRkanRIWjAxZ0I4cEVvZ1czT2c3ajc3YXUyUW9EMFBl?=
 =?utf-8?B?Q0lLL29kY2F6bDE2OFc4bnJUOVp2U2F1eWlqdjhDd09Wb1VjbFp5T0hER2tN?=
 =?utf-8?B?TUFiSHZBcVdPQXhIZlVMT054WkY3ZFByVituTkxWOGtNbTlJWlFRQWRHS1NW?=
 =?utf-8?B?QzBPVHpiVW5mMndoOUg3MEV0TUxLalp1ZlJtanNwWjgzQ3pGNWRCTGdrUmZs?=
 =?utf-8?B?UXQ4SHJzcnRvWVJpWDRydVZycVhvclZGTDZwTThZaDNJSVdwMVdsQWRZSi9i?=
 =?utf-8?B?Zk82YzNGcU43TStFMmVWcnZjKy95dW56WGJJV2g3SFZydFpzTHhiYnErZ054?=
 =?utf-8?B?NTljVWRQZDVqVGM2Q0ZVU0gxRnR4SWppRVRNSjJhcTlsb1crT0grM0FPajU0?=
 =?utf-8?B?bjVQMFNoT2tjTG1XWXhRbUVIS2NBS1pTQkp0aHF1OU0rMzIxVUlzT0MyTE5Q?=
 =?utf-8?B?NlQvVmFFaHdEa2l3cS9uUE9lcDc5SVBXQkRtejdJZXZwNVpMSTM3SVIxQjc0?=
 =?utf-8?B?R1Q2ejl3WjdmdGVOVEFNLzF1Zmc3MnF4QmZlWjJvSmNWM1h3Q1BnVW5Dc1V3?=
 =?utf-8?B?WUJ1VUg3Ym96RWljdVpPOEpYL1ppUnFrNnV4WlNlNmlvd1lON0s0SkRha1lF?=
 =?utf-8?B?K2E1YjIvbnIvZTdORDJXRERxTW9oUVQxMjViQVJtNGZxSjhEdkMzT1dCbWpn?=
 =?utf-8?B?UTRKaWlFaDMyZDFJa3BXZ3RralRRalAvd1djcGRRM3JBTVhuV2VUS0E3SE9k?=
 =?utf-8?B?L1ZhZysxcHZybVV0V3FOYWFjeUYxM1JCU2dDaXpvVnc0Z3UrZndYd29LZE5S?=
 =?utf-8?B?UFkySWZCNjRxOWF3cERLL2xVdUxjU250eUdDN0d4dGF0emlHS2VqRUFUVG82?=
 =?utf-8?B?V3VwcWNiSGtQRWgrSkgzU1QzcFZIUTJZQUVMbGZ6Y2VEOUM0aXZQMnFKMXp6?=
 =?utf-8?B?aWhqUUV4d0htaDAzOW1XSHJwWHBwbzhId3BiRFFWcUlhVkxLVEl4WDlxWW9y?=
 =?utf-8?B?NVJZWUpWajY2WXdZMEJuOUNkcUttTFFlbzNSbm9QL1IxMWw1aGNjNmRJb3Ax?=
 =?utf-8?B?bkdmMEJqdTgyUU1NUHJwL0MwMmNUZERUbVpaNTRZdXgzL0xtYitJUjFSaVo1?=
 =?utf-8?B?MndoMW80WjNudDlFdVVnK3BkNTVOZXFXdGR0SnlBd0J4WUtPL3o1Z1J4dHZy?=
 =?utf-8?B?blpyS3JtMnh5TG02cUsrQXlQbFpJQk1HOW04blZHaWlCWWVWbE96Z2FaU0FN?=
 =?utf-8?B?dzF6dUppbDJ3bVRVMFprWURndnlCMWF6bm5odWlMQjM1aHREck1uK3FISXB6?=
 =?utf-8?B?WDVXZC8rZFZ2U1RZSVlsUGZES21HTDJVSWF3MWQrdlBmVm1ycUl1ZWw0OS9l?=
 =?utf-8?B?ZXZ5dnJ5MElDa2VhNmIvTGVPMC9DWTMrcUxDVmovTkYwQWhLZ2tWckloWkh2?=
 =?utf-8?B?T1pmVXZBV0ROZUdLWFAyZXVYcU1FU3c3cVdjZWhqMlRqUDF4YnQ5ajlUSkov?=
 =?utf-8?B?ZFNuazlCanFZeFBiK3o0dDJqRFV6RHl0cWZXRlp1WVREZWlxUkIxdVg4c1pF?=
 =?utf-8?B?N1JnTGdQVzVJKzRFQkdEeU1jblJGSFZTWXUzZUdGVUh5Wkx3RTl5bHAva1pL?=
 =?utf-8?B?eldTM0VyeHJCRVAxbDJWMi84eHdaRXZFVDZSVjNTUTlDeHljVUs5TUVtbjdl?=
 =?utf-8?B?NEcrL1lZWitGVW0ydGxXN2ZnOFM0L1BadUZvVUVwTTR3enV3RVNOa0Vkd1Ay?=
 =?utf-8?B?REZsemQwa0dZMDFCVXo3RGNwck41aVJTdFdLYlhTNGt1NWJVeFFiLzZ1VGNU?=
 =?utf-8?Q?xrcQXI9sVXJtn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0ZFczZCUGhsRjJYdlFrSllGQm1ESGlZVTgxNzFKaEt6NXBaZFV1L05JRmxu?=
 =?utf-8?B?ekN4bFhVUWdzK1lzZ3RZVkY3YWp3SUV4bE5pME1uMHJKOWxMMTVNSmhxZUY4?=
 =?utf-8?B?YVFvaTlhdDhPNzNWdnNCdHFYU3VtWmRoUmp3ck5kOXZMY09vWHZiaWF0cFpz?=
 =?utf-8?B?dUdUWU0wdUxkdjZjR25lZDFBVFdZR3F2UDl2dGdvMVNFM1h1VEpHTHBlTzBG?=
 =?utf-8?B?a0pJdjZYQmxYWG5kL0R5WlR0M2ZKWGgva056Qk9LcWpsalU1OVlEWS92R293?=
 =?utf-8?B?VUVRNnEzWDJMYTMwWEM1VDBMKzZCdEp3OWNvUWNsT2tnQjBhbGYzS0dIK0Np?=
 =?utf-8?B?ellvOEtETkwrR3NyRVlLTVQ2bzlrUStiaTg0Y3ZZWXBaRGdjbnJTeDlpd2g0?=
 =?utf-8?B?MTRCUHIzT2dNMnp4S25SVVc3ZXB4ZzI3WkF5L3ZqNnJOZHQyb296QXpOQklr?=
 =?utf-8?B?MTV5L1pqb2xMOU1GeVh3Y2xBQnRPanJQcTJzLzY5SnZlbG5VeVVrSVZPVDV6?=
 =?utf-8?B?a1lrbjdrY2laZzk4RHBrYVJ6UThIWk1IQlB4Z21OT21RTlJEaXJub3FoUURY?=
 =?utf-8?B?UTExQ2NsazFTM3RaL2pKRGQxQ01oZEZTdjYreE52VTMzMUE4S245ZTBJYXdK?=
 =?utf-8?B?SGxWSEFnbm11bnV6U2I5aks3aXArM3RjTUFaUk42bTdESTEwOXBsNFdOL3BX?=
 =?utf-8?B?UERXWjhuNWNZNzNVWDByaU5sRTVzR050cFRqM2U3SUxXdmVlOGwzbWV5Y1hs?=
 =?utf-8?B?ek1MNU1QeHpGd0IwakphU0hXZzZKSTNGaEQ2Rit6NTNab0ZzQlZXTW1xVzdE?=
 =?utf-8?B?aVgwVU9XREhXcFRYcFBKbGRGOG0xVmw0eFExVXlaZVNHVGJ4OXUvdmZtMTAy?=
 =?utf-8?B?eG9FYVBWa2xqeUlPaVA3bzV5ZHJwbUtkUTNvc0NieGhhQXVVWmFBa1JRbjJU?=
 =?utf-8?B?Q2xwNmxxYzZZeE82S095RFR1UXFpR1c5TkpFdWNJWCtYeDVrQ2dhaTFGQjE1?=
 =?utf-8?B?b1RqVFVOTGpkcVdLS1FHRGJidGNaVjBsOGZHbHREUmZHYmVydjRzVkZiVnJQ?=
 =?utf-8?B?VTZkeDVSbVhiMktPd0FPWTNuMlI2Sjk1MXAzVGExbnhPc01xVVYwa1NvT1Nr?=
 =?utf-8?B?cHVaL3BVQXlBZUVvNHdxalVpbUxMS1FUd3h0UjNTYnF1bGtPaGpudzhWcDM4?=
 =?utf-8?B?NDRoVWhBMmpSV1dLRWFzekQzcmN0NXNUQWtzMHo5ZmJHNmFvelAwZHU1Tnpx?=
 =?utf-8?B?djgzeVFMUjJqSXdyZHlHUTBabHBRNmtNZDBIRjJIN2dFZWREejRqVTZESXBT?=
 =?utf-8?B?ZHhaSGtjMGZjTzc5S2tCcXByVGRhTzdrMDI2YmtsbFZZMUs4NU1JeTN2RjFN?=
 =?utf-8?B?RVNGVEhkSmdubjhSc0R2MzBiUkIwVWV5OU93RlhNNno5eExqeHJ6UnlRc3VN?=
 =?utf-8?B?YXVMbmFUdUtxWmpDdytHSmtyQjNjN2U4b2NRSVE5WGJ6Znc0eWtQWmIyM0xI?=
 =?utf-8?B?YkVFa0NFN1BEbVpRNzcxN1lmNEdQVEZkRlU1bXBYVURYZWg5N1QzcFJ5OTNT?=
 =?utf-8?B?c2NMZjlia3o2OU83dk5LM01YOE9CbC9LYTc2a1VrbmRJVTVvV2NpcEJDUG0x?=
 =?utf-8?B?SlFjQ1NGLzVjcG5wZlk1T2Y2WFB6NEdnTzdlMUIyMjN5S09EVmtuQ1RDc05M?=
 =?utf-8?B?eit2bC9LUm1TT3NNQzVXMTlXdmRJd24xMm0zdjlDaWhXSEdPTlBVZnQwdVBF?=
 =?utf-8?B?VHNDb0lXek1vVHB1UVM1bmFKVEIwbmlZTUNOT2I1RXdRSEIvUzY2RFpyV2c4?=
 =?utf-8?B?bFdxdlpuRmkzT2VsRW5aSXIybEFRSjU1S1UzZ0dZRUUwZWxzR1hCWGNGeXpa?=
 =?utf-8?B?Njk2ZmMzNkNQeUd2SGtCSjNoVlZmd0RWWnRNTFRCeTgwM2hrTVJHbGg1QVpW?=
 =?utf-8?B?ODBxK2VjYjhwRVAxeGhWZmJmZkllRkVsZTA3MEE2MFVtWFpJVVJKeG4wNGlt?=
 =?utf-8?B?WFFLK0dkcjhBb0VHQnJGL1RHSWVsWkswZzhQUXI0cytkOERQcW82MDYwOG1w?=
 =?utf-8?B?dEk2WjZTVzZEVjNqVEhOMWlXRVJJNnBmYVBPcDdpR1hWQkNML09tMmRFT1Rm?=
 =?utf-8?Q?WcuCgidFCvbSytdjBEQRMq3X4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de7db5b8-a0f8-4462-7a99-08dd5988478b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2025 12:46:40.9535 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y+TOXyKyhs2CfGMzHfMv9+kwFnwnBWo5xdBjWi8n8LTzvSznJt182TuNhMsbdf71b2KtCa0V8KXMpjOiyUMKtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7662
Received-SPF: softfail client-ip=2a01:111:f403:2414::625;
 envelope-from=avihaih@nvidia.com;
 helo=NAM11-BN8-obe.outbound.protection.outlook.com
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


On 19/02/2025 22:33, Maciej S. Szmigiero wrote:
> External email: Use caution opening links or attachments
>
>
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>
> A new function multifd_queue_device_state() is provided for device to queue
> its state for transmission via a multifd channel.
>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>   include/migration/misc.h         |   4 ++
>   migration/meson.build            |   1 +
>   migration/multifd-device-state.c | 115 +++++++++++++++++++++++++++++++
>   migration/multifd-nocomp.c       |  14 +++-
>   migration/multifd.c              |  42 +++++++++--
>   migration/multifd.h              |  27 +++++---
>   6 files changed, 187 insertions(+), 16 deletions(-)
>   create mode 100644 migration/multifd-device-state.c
>
> diff --git a/include/migration/misc.h b/include/migration/misc.h
> index 4c171f4e897e..bd3b725fa0b7 100644
> --- a/include/migration/misc.h
> +++ b/include/migration/misc.h
> @@ -118,4 +118,8 @@ bool migrate_is_uri(const char *uri);
>   bool migrate_uri_parse(const char *uri, MigrationChannel **channel,
>                          Error **errp);
>
> +/* migration/multifd-device-state.c */
> +bool multifd_queue_device_state(char *idstr, uint32_t instance_id,
> +                                char *data, size_t len);
> +
>   #endif
> diff --git a/migration/meson.build b/migration/meson.build
> index d3bfe84d6204..9aa48b290e2a 100644
> --- a/migration/meson.build
> +++ b/migration/meson.build
> @@ -25,6 +25,7 @@ system_ss.add(files(
>     'migration-hmp-cmds.c',
>     'migration.c',
>     'multifd.c',
> +  'multifd-device-state.c',
>     'multifd-nocomp.c',
>     'multifd-zlib.c',
>     'multifd-zero-page.c',
> diff --git a/migration/multifd-device-state.c b/migration/multifd-device-state.c
> new file mode 100644
> index 000000000000..ab83773e2d62
> --- /dev/null
> +++ b/migration/multifd-device-state.c
> @@ -0,0 +1,115 @@
> +/*
> + * Multifd device state migration
> + *
> + * Copyright (C) 2024,2025 Oracle and/or its affiliates.
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/lockable.h"
> +#include "migration/misc.h"
> +#include "multifd.h"
> +
> +static struct {
> +    QemuMutex queue_job_mutex;
> +
> +    MultiFDSendData *send_data;
> +} *multifd_send_device_state;
> +
> +size_t multifd_device_state_payload_size(void)
> +{
> +    return sizeof(MultiFDDeviceState_t);
> +}
> +
> +void multifd_device_state_send_setup(void)
> +{
> +    assert(!multifd_send_device_state);
> +    multifd_send_device_state = g_malloc(sizeof(*multifd_send_device_state));
> +
> +    qemu_mutex_init(&multifd_send_device_state->queue_job_mutex);
> +
> +    multifd_send_device_state->send_data = multifd_send_data_alloc();
> +}
> +
> +void multifd_device_state_send_cleanup(void)
> +{
> +    g_clear_pointer(&multifd_send_device_state->send_data,
> +                    multifd_send_data_free);
> +
> +    qemu_mutex_destroy(&multifd_send_device_state->queue_job_mutex);
> +
> +    g_clear_pointer(&multifd_send_device_state, g_free);
> +}
> +
> +void multifd_send_data_clear_device_state(MultiFDDeviceState_t *device_state)
> +{
> +    g_clear_pointer(&device_state->idstr, g_free);
> +    g_clear_pointer(&device_state->buf, g_free);
> +}
> +
> +static void multifd_device_state_fill_packet(MultiFDSendParams *p)
> +{
> +    MultiFDDeviceState_t *device_state = &p->data->u.device_state;
> +    MultiFDPacketDeviceState_t *packet = p->packet_device_state;
> +
> +    packet->hdr.flags = cpu_to_be32(p->flags);
> +    strncpy(packet->idstr, device_state->idstr, sizeof(packet->idstr));

(I think we talked about this in v2):
Looking at idstr creation code, idstr is always NULL terminated. It's 
also treated everywhere as a NULL terminated string.
For consistency and to avoid confusion, I'd treat it as a NULL 
terminated string here too (use strcpy, remove the QEMU_NONSTRING from 
its definition, etc.).
This will also avoid strncpy() unnecessary zeroing of the extra bytes.

Thanks.

> +    packet->instance_id = cpu_to_be32(device_state->instance_id);
> +    packet->next_packet_size = cpu_to_be32(p->next_packet_size);
> +}
> +
> +static void multifd_prepare_header_device_state(MultiFDSendParams *p)
> +{
> +    p->iov[0].iov_len = sizeof(*p->packet_device_state);
> +    p->iov[0].iov_base = p->packet_device_state;
> +    p->iovs_num++;
> +}
> +
> +void multifd_device_state_send_prepare(MultiFDSendParams *p)
> +{
> +    MultiFDDeviceState_t *device_state = &p->data->u.device_state;
> +
> +    assert(multifd_payload_device_state(p->data));
> +
> +    multifd_prepare_header_device_state(p);
> +
> +    assert(!(p->flags & MULTIFD_FLAG_SYNC));
> +
> +    p->next_packet_size = device_state->buf_len;
> +    if (p->next_packet_size > 0) {
> +        p->iov[p->iovs_num].iov_base = device_state->buf;
> +        p->iov[p->iovs_num].iov_len = p->next_packet_size;
> +        p->iovs_num++;
> +    }
> +
> +    p->flags |= MULTIFD_FLAG_NOCOMP | MULTIFD_FLAG_DEVICE_STATE;
> +
> +    multifd_device_state_fill_packet(p);
> +}
> +
> +bool multifd_queue_device_state(char *idstr, uint32_t instance_id,
> +                                char *data, size_t len)
> +{
> +    /* Device state submissions can come from multiple threads */
> +    QEMU_LOCK_GUARD(&multifd_send_device_state->queue_job_mutex);
> +    MultiFDDeviceState_t *device_state;
> +
> +    assert(multifd_payload_empty(multifd_send_device_state->send_data));
> +
> +    multifd_set_payload_type(multifd_send_device_state->send_data,
> +                             MULTIFD_PAYLOAD_DEVICE_STATE);
> +    device_state = &multifd_send_device_state->send_data->u.device_state;
> +    device_state->idstr = g_strdup(idstr);
> +    device_state->instance_id = instance_id;
> +    device_state->buf = g_memdup2(data, len);
> +    device_state->buf_len = len;
> +
> +    if (!multifd_send(&multifd_send_device_state->send_data)) {
> +        multifd_send_data_clear(multifd_send_device_state->send_data);
> +        return false;
> +    }
> +
> +    return true;
> +}
> diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
> index e46e79d8b272..c00804652383 100644
> --- a/migration/multifd-nocomp.c
> +++ b/migration/multifd-nocomp.c
> @@ -14,6 +14,7 @@
>   #include "exec/ramblock.h"
>   #include "exec/target_page.h"
>   #include "file.h"
> +#include "migration-stats.h"
>   #include "multifd.h"
>   #include "options.h"
>   #include "qapi/error.h"
> @@ -85,6 +86,13 @@ static void multifd_nocomp_send_cleanup(MultiFDSendParams *p, Error **errp)
>       return;
>   }
>
> +static void multifd_ram_prepare_header(MultiFDSendParams *p)
> +{
> +    p->iov[0].iov_len = p->packet_len;
> +    p->iov[0].iov_base = p->packet;
> +    p->iovs_num++;
> +}
> +
>   static void multifd_send_prepare_iovs(MultiFDSendParams *p)
>   {
>       MultiFDPages_t *pages = &p->data->u.ram;
> @@ -118,7 +126,7 @@ static int multifd_nocomp_send_prepare(MultiFDSendParams *p, Error **errp)
>            * Only !zerocopy needs the header in IOV; zerocopy will
>            * send it separately.
>            */
> -        multifd_send_prepare_header(p);
> +        multifd_ram_prepare_header(p);
>       }
>
>       multifd_send_prepare_iovs(p);
> @@ -133,6 +141,8 @@ static int multifd_nocomp_send_prepare(MultiFDSendParams *p, Error **errp)
>           if (ret != 0) {
>               return -1;
>           }
> +
> +        stat64_add(&mig_stats.multifd_bytes, p->packet_len);
>       }
>
>       return 0;
> @@ -431,7 +441,7 @@ int multifd_ram_flush_and_sync(QEMUFile *f)
>   bool multifd_send_prepare_common(MultiFDSendParams *p)
>   {
>       MultiFDPages_t *pages = &p->data->u.ram;
> -    multifd_send_prepare_header(p);
> +    multifd_ram_prepare_header(p);
>       multifd_send_zero_page_detect(p);
>
>       if (!pages->normal_num) {
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 0092547a4f97..3394c2ae12fd 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -12,6 +12,7 @@
>
>   #include "qemu/osdep.h"
>   #include "qemu/cutils.h"
> +#include "qemu/iov.h"
>   #include "qemu/rcu.h"
>   #include "exec/target_page.h"
>   #include "system/system.h"
> @@ -19,6 +20,7 @@
>   #include "qemu/error-report.h"
>   #include "qapi/error.h"
>   #include "file.h"
> +#include "migration/misc.h"
>   #include "migration.h"
>   #include "migration-stats.h"
>   #include "savevm.h"
> @@ -111,7 +113,9 @@ MultiFDSendData *multifd_send_data_alloc(void)
>        * added to the union in the future are larger than
>        * (MultiFDPages_t + flex array).
>        */
> -    max_payload_size = MAX(multifd_ram_payload_size(), sizeof(MultiFDPayload));
> +    max_payload_size = MAX(multifd_ram_payload_size(),
> +                           multifd_device_state_payload_size());
> +    max_payload_size = MAX(max_payload_size, sizeof(MultiFDPayload));
>
>       /*
>        * Account for any holes the compiler might insert. We can't pack
> @@ -130,6 +134,9 @@ void multifd_send_data_clear(MultiFDSendData *data)
>       }
>
>       switch (data->type) {
> +    case MULTIFD_PAYLOAD_DEVICE_STATE:
> +        multifd_send_data_clear_device_state(&data->u.device_state);
> +        break;
>       default:
>           /* Nothing to do */
>           break;
> @@ -232,6 +239,7 @@ static int multifd_recv_initial_packet(QIOChannel *c, Error **errp)
>       return msg.id;
>   }
>
> +/* Fills a RAM multifd packet */
>   void multifd_send_fill_packet(MultiFDSendParams *p)
>   {
>       MultiFDPacket_t *packet = p->packet;
> @@ -524,6 +532,7 @@ static bool multifd_send_cleanup_channel(MultiFDSendParams *p, Error **errp)
>       p->name = NULL;
>       g_clear_pointer(&p->data, multifd_send_data_free);
>       p->packet_len = 0;
> +    g_clear_pointer(&p->packet_device_state, g_free);
>       g_free(p->packet);
>       p->packet = NULL;
>       multifd_send_state->ops->send_cleanup(p, errp);
> @@ -536,6 +545,7 @@ static void multifd_send_cleanup_state(void)
>   {
>       file_cleanup_outgoing_migration();
>       socket_cleanup_outgoing_migration();
> +    multifd_device_state_send_cleanup();
>       qemu_sem_destroy(&multifd_send_state->channels_created);
>       qemu_sem_destroy(&multifd_send_state->channels_ready);
>       qemu_mutex_destroy(&multifd_send_state->multifd_send_mutex);
> @@ -694,16 +704,32 @@ static void *multifd_send_thread(void *opaque)
>            * qatomic_store_release() in multifd_send().
>            */
>           if (qatomic_load_acquire(&p->pending_job)) {
> +            bool is_device_state = multifd_payload_device_state(p->data);
> +            size_t total_size;
> +
>               p->flags = 0;
>               p->iovs_num = 0;
>               assert(!multifd_payload_empty(p->data));
>
> -            ret = multifd_send_state->ops->send_prepare(p, &local_err);
> -            if (ret != 0) {
> -                break;
> +            if (is_device_state) {
> +                multifd_device_state_send_prepare(p);
> +            } else {
> +                ret = multifd_send_state->ops->send_prepare(p, &local_err);
> +                if (ret != 0) {
> +                    break;
> +                }
>               }
>
> +            /*
> +             * The packet header in the zerocopy RAM case is accounted for
> +             * in multifd_nocomp_send_prepare() - where it is actually
> +             * being sent.
> +             */
> +            total_size = iov_size(p->iov, p->iovs_num);
> +
>               if (migrate_mapped_ram()) {
> +                assert(!is_device_state);
> +
>                   ret = file_write_ramblock_iov(p->c, p->iov, p->iovs_num,
>                                                 &p->data->u.ram, &local_err);
>               } else {
> @@ -716,8 +742,7 @@ static void *multifd_send_thread(void *opaque)
>                   break;
>               }
>
> -            stat64_add(&mig_stats.multifd_bytes,
> -                       (uint64_t)p->next_packet_size + p->packet_len);
> +            stat64_add(&mig_stats.multifd_bytes, total_size);
>
>               p->next_packet_size = 0;
>               multifd_send_data_clear(p->data);
> @@ -938,6 +963,9 @@ bool multifd_send_setup(void)
>               p->packet_len = sizeof(MultiFDPacket_t)
>                             + sizeof(uint64_t) * page_count;
>               p->packet = g_malloc0(p->packet_len);
> +            p->packet_device_state = g_malloc0(sizeof(*p->packet_device_state));
> +            p->packet_device_state->hdr.magic = cpu_to_be32(MULTIFD_MAGIC);
> +            p->packet_device_state->hdr.version = cpu_to_be32(MULTIFD_VERSION);
>           }
>           p->name = g_strdup_printf(MIGRATION_THREAD_SRC_MULTIFD, i);
>           p->write_flags = 0;
> @@ -973,6 +1001,8 @@ bool multifd_send_setup(void)
>           assert(p->iov);
>       }
>
> +    multifd_device_state_send_setup();
> +
>       return true;
>
>   err:
> diff --git a/migration/multifd.h b/migration/multifd.h
> index 20a4bba58ef4..883a43c1d79e 100644
> --- a/migration/multifd.h
> +++ b/migration/multifd.h
> @@ -137,10 +137,12 @@ typedef struct {
>   typedef enum {
>       MULTIFD_PAYLOAD_NONE,
>       MULTIFD_PAYLOAD_RAM,
> +    MULTIFD_PAYLOAD_DEVICE_STATE,
>   } MultiFDPayloadType;
>
>   typedef union MultiFDPayload {
>       MultiFDPages_t ram;
> +    MultiFDDeviceState_t device_state;
>   } MultiFDPayload;
>
>   struct MultiFDSendData {
> @@ -153,6 +155,11 @@ static inline bool multifd_payload_empty(MultiFDSendData *data)
>       return data->type == MULTIFD_PAYLOAD_NONE;
>   }
>
> +static inline bool multifd_payload_device_state(MultiFDSendData *data)
> +{
> +    return data->type == MULTIFD_PAYLOAD_DEVICE_STATE;
> +}
> +
>   static inline void multifd_set_payload_type(MultiFDSendData *data,
>                                               MultiFDPayloadType type)
>   {
> @@ -205,8 +212,9 @@ typedef struct {
>
>       /* thread local variables. No locking required */
>
> -    /* pointer to the packet */
> +    /* pointers to the possible packet types */
>       MultiFDPacket_t *packet;
> +    MultiFDPacketDeviceState_t *packet_device_state;
>       /* size of the next packet that contains pages */
>       uint32_t next_packet_size;
>       /* packets sent through this channel */
> @@ -365,13 +373,6 @@ bool multifd_send_prepare_common(MultiFDSendParams *p);
>   void multifd_send_zero_page_detect(MultiFDSendParams *p);
>   void multifd_recv_zero_page_process(MultiFDRecvParams *p);
>
> -static inline void multifd_send_prepare_header(MultiFDSendParams *p)
> -{
> -    p->iov[0].iov_len = p->packet_len;
> -    p->iov[0].iov_base = p->packet;
> -    p->iovs_num++;
> -}
> -
>   void multifd_channel_connect(MultiFDSendParams *p, QIOChannel *ioc);
>   bool multifd_send(MultiFDSendData **send_data);
>   MultiFDSendData *multifd_send_data_alloc(void);
> @@ -396,4 +397,14 @@ bool multifd_ram_sync_per_section(void);
>   size_t multifd_ram_payload_size(void);
>   void multifd_ram_fill_packet(MultiFDSendParams *p);
>   int multifd_ram_unfill_packet(MultiFDRecvParams *p, Error **errp);
> +
> +size_t multifd_device_state_payload_size(void);
> +
> +void multifd_send_data_clear_device_state(MultiFDDeviceState_t *device_state);
> +
> +void multifd_device_state_send_setup(void);
> +void multifd_device_state_send_cleanup(void);
> +
> +void multifd_device_state_send_prepare(MultiFDSendParams *p);
> +
>   #endif

