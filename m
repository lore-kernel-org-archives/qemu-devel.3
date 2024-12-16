Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4046CE77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 14:57:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNCWP-00031i-Lh; Mon, 16 Dec 2024 09:56:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tNCW1-0002ut-RW
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 09:56:15 -0500
Received: from mail-dm6nam11on2061c.outbound.protection.outlook.com
 ([2a01:111:f403:2415::61c]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1tNCVz-0005Ho-O8
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 09:56:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RsDpPAQsUyYs+w4Fc5tEtVmdq1Qt6lbXwAgyMnEzWZLo9Z40uqxUYD8iFW0RwdG+sXCRqpN4rxhNQhEczfCtT8TkRbGlor0z1RZYc4Ew6mJZgRH1kML68f4LnZXu7tDIGvSPa/Lpa71i5kq7mP/oV/H8xSQMkVz+7p2WS74QlxDYGFLjb8pAfmW+VsEjaTNQFp+xyw9hS5vmgGqqR7WGS0qh7955ALizmyEBUIVIb6pLK+xY5LmUO4BqiOfjAJ9EwyJxnGUDMpizo30exVKFLzHEzbVPd39PE1T9P2g9nrvuieWoRYa1mKekc90GX7pVcOqSHZKRF27zzGG4bvzx/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZM6Lf5cxVQbQ2l+2FsC0Ej5SpQf89Mzqoa9o06tHkHY=;
 b=vUi5DYzh4oZP7mLyuyWlW2mkEES6VaAAVp75oYBDefJ0Gxg+nPSAUq8MmEu4X97IP022s0ad1mQZpJFZvb88y/dVHm5e3+dKMIEkk6qs5oaQc+ntGm3KqBUGIPDq5fIrrwGHubN9L6iNUbaqgf8QmZYWK3TXPMpgBvMTPWffCb22jCQSoOrNmBbqlG/ZdMu7olGK8CqXStNzQ6/0vXY8D6B56wo3emQvECFrUzA8FSNzlGpR0lkFxYNilQjzl0j/00QCovVGanVPbM3HDYETeL/jmCOKno2fqjVNkT6X2OvHBlj5SrV2QL0BhHOXZd+v0E7E4fmLFGu2xl9cRmH0Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZM6Lf5cxVQbQ2l+2FsC0Ej5SpQf89Mzqoa9o06tHkHY=;
 b=C4BJ68GqceoeQhAUBEj9G+RkFmYRZTHtduGPDQ6UVbd2JoNPTIgPMWmov/7BypF46SeDeuSu8R3eihRusDaIGENrjEtB4HpomJHLdoYQyf2vH3vZyq9D/JBYg8QNZpcmuKcQSWaImb1UX2/5BgvoOL4Qe/8014EGscQKm35TpZqGGIGriQDbiFNtuNbYFZiPSFBrcdrdbIsuqdLl95VUbj3LPFtSkO2ZACnbh82cIzPLglzSzvi4Hy1U7eLGmdTVQ5Fos50avjlMBUw0sQ6q+U3HZ87bp2RiSOEYLHe1YTRdDIPiGWNXpN+xllnC04dc5a4W5Qalzuzw2WHYzgJBEA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by DM3PR12MB9392.namprd12.prod.outlook.com (2603:10b6:0:44::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.22; Mon, 16 Dec 2024 14:56:03 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 14:56:02 +0000
Message-ID: <63082412-a42f-42b9-88f5-8e40a8f28c8b@nvidia.com>
Date: Mon, 16 Dec 2024 16:55:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] vfio/migration: Refactor
 vfio_devices_all_running_and_mig_active() logic
To: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hyman Huang <yong.huang@smartx.com>, Maor Gottlieb <maorg@nvidia.com>
References: <20241216094638.26406-1-avihaih@nvidia.com>
 <20241216094638.26406-4-avihaih@nvidia.com>
 <14070e26-ef99-4a6c-b3ba-ef910270856d@oracle.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <14070e26-ef99-4a6c-b3ba-ef910270856d@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0146.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::25) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|DM3PR12MB9392:EE_
X-MS-Office365-Filtering-Correlation-Id: e9faf628-f3a6-44a7-75b0-08dd1de1c2ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXZIRklld2dVbExCWFhQVWFETTJMbDZENEpTWEp3a2t1TStTRmNuMVhKRlVj?=
 =?utf-8?B?SXUxcFFYR3RWLzM4Q2l5ck9SdmR3WHlybzZrQVR0M2FTQkcxaXlxcTdzYzNl?=
 =?utf-8?B?ZWJNVXRST0NjZFFXNHgyVWg5ZENTTlg4RGtoZjgzT2huZ2tudzNpbkZLc0Mx?=
 =?utf-8?B?THlqVllLZUZiWkRXbUtzeXNBUHRMbGc4WSt3aDlpTWdQWnpNMzNRdFFoVHNj?=
 =?utf-8?B?WUlkSlQ5S0ZCNG1RK25XNDJCSVorUStSd0wzdVBGQmQ5QUpYVTVjV1JzMkR1?=
 =?utf-8?B?WDhlQUJZdURHdVY5QWV6dkd0cjd1TjZhOVNDVWYxWDZKUFo4dnlHZUd1YTZ4?=
 =?utf-8?B?S3hHaGxwSlBGZEJmL2dKQjVaRnRuTFl2eURUS3JwRFYrR3dzME5CV2hqUmZX?=
 =?utf-8?B?MXIvd0NMT2F1eXhPQW9ad1lPa01JaHlIOENzbkNOZWF3Mjk4a0hvNzBpL2Yv?=
 =?utf-8?B?Vm9yOTEwd2FmLzBRWXpqMzZ2MUNJNjRaaG04UmVMTmZVOG4wMEo2VkdFNHpk?=
 =?utf-8?B?VmlFNDlyM1ZvU0NvOVVpTjdRUENuK1l6U05sMlYzZElsRWRQU0ovRmdkd2x3?=
 =?utf-8?B?b2dWU05XSUEwZ3lMRThTRjdXRWdOQ3ZpQ2QvYTJNUzZXZmNGdmRaMWErQkc1?=
 =?utf-8?B?OTJobzUwdEFkaGZVekVlV1pxenpZNEl6dlpIallVS3g3L1AvemxHTlAwdm82?=
 =?utf-8?B?UWpwaU1iVEV5b1FLS01taHpXODFUS1I3OFM0NEoxcDFIWXMxbUd1MGF0Unl1?=
 =?utf-8?B?ZHZlc1JMQmlpM3IzbkkxQkZWVVY1djVYenRKSGRaSkJqcjVLWGFEaEk1cjBj?=
 =?utf-8?B?NHpteXRGYWVoS0xuclg0VVcrM3RxZkQ2bmw5R0hqYytEOUNPaUF3ZkN6em9o?=
 =?utf-8?B?Sk15VTRNTndDeno0NE1GbG1OMkRTNXd4MkpEZDhUTE9MTVZYV3owVFk1dlBl?=
 =?utf-8?B?Q1BXK0JZcXNaQjJQOTloUjVzUjExZnNRM3F4Sm0wNW84OCsrUmo0UlU1dXVx?=
 =?utf-8?B?dHJ4STI4MlFRcW1Cem1GSThKeXNLSDJOa1V0cENvUWxMSU9RUVVCbGxTa3c0?=
 =?utf-8?B?Z3VxUVFsM1B4SVM3SFA4TDVXTXdrU0NJNTRwUy9vMnlkUkx4YUROSkZFajE1?=
 =?utf-8?B?R2JqbXpRckp6VXRKUEVuTnRYSzlHNm81aC94d2VvWHZzVThyUGFrdEd1T0tX?=
 =?utf-8?B?RjgrL3c3eTVNd0dnZTNyV1pLbnVWSVVKYlJ0VGhaU3BiY0JtZjFsL0ovY3dq?=
 =?utf-8?B?UnNIeHRrNy81SWhHdFlOYTUzRUJQa3FreFYyQ0VGME9DQUtxWjA0UnkxM2th?=
 =?utf-8?B?UngwUWgrdy8zbUlUK0hLUHQvTnA4cU5hRlNoM1p1Y2RUYTNDd3d4NjkzN3NU?=
 =?utf-8?B?WmgzbGtlVHJXZXROcUY1TGRLQ0VPYjFYZWZyUHpheVdmd0ZvOHB5dndhMmVw?=
 =?utf-8?B?QVllYUNXSTh0Wi9CUThmWTZMS25OOEVZYlpLSTZHM21KY3c1K2ZKSHZqdU52?=
 =?utf-8?B?VFZCWXZpcjh5cVdsOXZteHhSSnRnV2t2emx4RnJuOFZKVWplQUN1OHdBVjQ0?=
 =?utf-8?B?M0RrSjBqK1hqaWZxV0lEa1ZldTRJVVBPK2tnb0p4ZTB5elg5ejNSYWt2eVRC?=
 =?utf-8?B?OUtwVHVXSmVmQmZIcjlVNmgwZGlxU2I3MHpSTjhyd2x2ZDdiSThUMTVwY0ht?=
 =?utf-8?B?Vi93NHJWZ2F4cWh6T0t1T1pVU0pzbE96Q3F3NGNDTkp6MnJHRlV2SGNteVRY?=
 =?utf-8?B?bXFlRHc3K0xyeDlwV1NCaFpjRXBHTW1lZWJIWmQ5NzNITEFNYWR2YUxBaUpW?=
 =?utf-8?B?eHBUR2RIbHZrQURWOGFvVk9RclBxUDF3WS9DY2RlY1dnWjQ0cUZPV0FOd0ha?=
 =?utf-8?Q?BfVWVO+BQfIXz?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUNGWXVYNlc0QW9tVEY5YlNYSFFXNS84TG1lTWFJaVBzdEd1eXA2QnFIeENt?=
 =?utf-8?B?TUVNWU5TcGVTaEVxRVRXZXEyaTVieWoyb0pqczdwUFBTeGxXSjF6Wkp1eUdv?=
 =?utf-8?B?ekVmcnBTUWYxTUdzcTkyck9aemxjM0UyY0FJOWVtTFZPVVBXdTVHeVRYdG1U?=
 =?utf-8?B?UlhGTHBPbEVhaHpaVU9GOExBaTluLzIxSnJFV1hRNjAwUVdmVXFHTnlqUElH?=
 =?utf-8?B?cUROeWR2ZVQ5blYwbkdrUHdSQzZrM0drRFl2aXRybjRNdGZYaHM0ZlVQSXdQ?=
 =?utf-8?B?U2FlY3lUbExFQ1hGdTcrL2t0WjVCcldqTm5MbW9EMzlBbU5oRjdlc1pyb1Vo?=
 =?utf-8?B?K1IzS1J6ZXBDNmVNK0RwUTdyYWhNM3ZrY3Z0R0g2d1FNSS9ZMEo4dnlWNTR2?=
 =?utf-8?B?ejMvbVVCMElTZGdiSElIemUzSG91VmNsaElPNlhsUTd6V1pWbExCM1RGbUZQ?=
 =?utf-8?B?ZjE1WXpsSEFCeG1jU1o0MzlUdnJtM1FKOHR5L1puTVl1cHhaaStsVEh3c1Vn?=
 =?utf-8?B?NEExS0RpRXF3NjZnUm4rWS9uWkJjWFFmaFJwdGNhdWNDbE1MNitYK1V3dWsv?=
 =?utf-8?B?OWEwVTBabUVRUEJrTC9KV3FTMVhCOWRNUmVpUGJZVkNwdTl3UWpjRGVOSkpp?=
 =?utf-8?B?ZnlNT09XVmdOVEV5ZzgyM04zb3NWVnlnZ3REWmpjZHhsR0k0Zlh1UW56S3Rm?=
 =?utf-8?B?Y0RVRC85bVZWVUNhVi9IY3FlQWY0OFc3N08yS1c5aVZrMW5XR3NRTWFIQmJD?=
 =?utf-8?B?YXorWGFKSjlaSnUybVVkZ3ZQdmpvYWp0UzVFTk1KSkE0amFaZlV3UGh0QkZq?=
 =?utf-8?B?ZVNNY0lWL0c3UlR5dU1wMHZnV1Q0VUhQUjNIWmhZTWxWNWd1Y3d5Znp2YWZH?=
 =?utf-8?B?Y3RHSFlEMVBycjdzZVBkWEJqS3RQUWpKdWtIeEJjZi9GaXg3aXZkRnJ5bW92?=
 =?utf-8?B?ZzU2OWp3Y3RDZmpxSlordTgxYmt0R2lyNWhocHprNDI0K2JndW5VZ1FKWE9K?=
 =?utf-8?B?dEdYL2FLd0R1ZzNEeTJjNTN0cmJCWXhMWWRUaHpBRjNmQ244MUhoT3dXMHBm?=
 =?utf-8?B?NGhSL2poZVc4WnNBZHh2WUV6QVBSb0pKd3p5bi92UG5ZRTBLMTVIZFo5OHc1?=
 =?utf-8?B?akJoKzN6c1BXK2pPKzVqOW5OU0dYTVRKSEdGL2d1dDAwdXE1Q09Fa05BWmM1?=
 =?utf-8?B?Q2tINHEyT3hYcW1qa1Nremd3bms1K2VESVJpZzFPQkNBaTV0WVFMU3l1M1ow?=
 =?utf-8?B?UDY4M01XK0IveDRONXRVVytCUThkOEpOR1Q4dVdvRkcrQnZnb3ZCRmNsLzdi?=
 =?utf-8?B?ekVLNUpWdC9qQ2c5QTl4UjAzWlkvNTVxNTN2Q0RwYUd1dFNEbUpCSlcvcGJo?=
 =?utf-8?B?YmkzbFhoSzFYcVFzb1J3VHhCL01DS2p1VGFsM1RHSEVNaCtIZTgyR0JrTG4z?=
 =?utf-8?B?eVVCeS9QR0g2cG1zOFJqOGZlTHN1Y0NTR1lMN3IwUkpiaTVHalZsWkNlM0hY?=
 =?utf-8?B?Y3NJNjdjbE8xMGc5Mnc3KzhHVVB1V0F4Z3NPS0FVb2VQa283bWlBQjVvSzhj?=
 =?utf-8?B?RUJTRHU0d0VlYnVzS3RCcU9BWHRUUHZlKzM0LzNsZGlSNTJ5VE5PdUVONS9N?=
 =?utf-8?B?V1FDY2pndFdMM2Nzbzc2VWhER2ZlZmhXZlZ1NUdiTXEybjY2MXF6ZC84WTlE?=
 =?utf-8?B?R3FaVzhYcTdKRWl4S1N0UDFzU2VHc243WWMrd1JWQ216WndFYktObFA0bExT?=
 =?utf-8?B?bkUxVVoxUEJoc0FnaWlybTM5NExuUlpEam11REVmSjNORTBIV21kVGtIbHJT?=
 =?utf-8?B?NUd1bU5NOUV0RXRQaGQ3cUJqNlpJbGNqSlZGN1BmZjNMSTJpbDVZcjJpNC9k?=
 =?utf-8?B?OEFncjBCS0hMS1lJOCtGUW9TRWNkTW1WU01GNW9RdDFBZWxwN3FhUnQwSTF3?=
 =?utf-8?B?ODMxaEpJcTRQYVkzWDNsMXRvamNuaWpEakhOQkFncHIzT2VqTmNac3kyaVZF?=
 =?utf-8?B?bkIxRVZYQU13ZHNKT3B2TVVKajM4dFdhcE9VMWhlMXF3NlhSNmVqNFZ3VWpW?=
 =?utf-8?B?L0M3OUs2bjB2d3d4VmVlUlFMTkNmYTNQSkgwcENKcEoyMnhwWlBvTDBQTzA5?=
 =?utf-8?Q?enbYbuNU4ETe+YmjqwViLLwVD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9faf628-f3a6-44a7-75b0-08dd1de1c2ad
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 14:56:02.8831 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FnJVHI5BdvmOQQZIBfPI7mJzhdssmfY6JucBzKAQi8P0s+GIN6W86/Ejjxq8aMPNiMdyK/0XRK8bPiP1htHs/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9392
Received-SPF: softfail client-ip=2a01:111:f403:2415::61c;
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


On 16/12/2024 14:45, Joao Martins wrote:
> External email: Use caution opening links or attachments
>
>
> On 16/12/2024 09:46, Avihai Horon wrote:
>> During DMA unmap with vIOMMU, vfio_devices_all_running_and_mig_active()
>> is used to check whether a dirty page log sync of the unmapped pages is
>> required. Such log sync is needed during migration pre-copy phase, and
>> the current logic detects it by checking if migration is active and if
>> the VFIO devices are running.
>>
>> However, recently there has been an effort to simplify the migration
>> status API and reduce it to a single migration_is_running() function.
>>
>> To accommodate this, refactor vfio_devices_all_running_and_mig_active()
>> logic so it won't use migration_is_active().
>>
>> Do it by modifying the logic to check if migration is running and dirty
>> tracking has been started. This should be equivalent to the previous
>> logic because when the guest is stopped there shouldn't be DMA unmaps
>> coming from it. Also rename the function properly.
>>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
>> ---
>>   include/hw/vfio/vfio-common.h |  3 +--
>>   hw/vfio/common.c              | 28 ++++------------------------
>>   hw/vfio/container.c           |  2 +-
>>   3 files changed, 6 insertions(+), 27 deletions(-)
>>
>> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
>> index e0ce6ec3a9..c23ca34871 100644
>> --- a/include/hw/vfio/vfio-common.h
>> +++ b/include/hw/vfio/vfio-common.h
>> @@ -296,8 +296,7 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp);
>>   void vfio_migration_exit(VFIODevice *vbasedev);
>>
>>   int vfio_bitmap_alloc(VFIOBitmap *vbmap, hwaddr size);
>> -bool
>> -vfio_devices_all_running_and_mig_active(const VFIOContainerBase *bcontainer);
>> +bool vfio_dma_unmap_dirty_sync_needed(const VFIOContainerBase *bcontainer);
>>   bool
>>   vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer);
>>   int vfio_devices_query_dirty_bitmap(const VFIOContainerBase *bcontainer,
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index a99796403e..81fba81a6f 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -229,34 +229,14 @@ bool vfio_devices_all_device_dirty_tracking(const VFIOContainerBase *bcontainer)
>>       return true;
>>   }
>>
>> -/*
>> - * Check if all VFIO devices are running and migration is active, which is
>> - * essentially equivalent to the migration being in pre-copy phase.
>> - */
>> -bool
>> -vfio_devices_all_running_and_mig_active(const VFIOContainerBase *bcontainer)
>> +bool vfio_dma_unmap_dirty_sync_needed(const VFIOContainerBase *bcontainer)
>>   {
>> -    VFIODevice *vbasedev;
>> -
>> -    if (!migration_is_active()) {
>> +    if (!migration_is_running()) {
>>           return false;
>>       }
>>
>> -    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
>> -        VFIOMigration *migration = vbasedev->migration;
>> -
>> -        if (!migration) {
>> -            return false;
>> -        }
>> -
>> -        if (vfio_device_state_is_running(vbasedev) ||
>> -            vfio_device_state_is_precopy(vbasedev)) {
>> -            continue;
>> -        } else {
>> -            return false;
>> -        }
> Functionally the change implies that even if non-migratable VFIO devices behind
> IOMMUs with dirty tracking would still sync DMA bitmap. I think this is OK as it
> increases the coverage for calc-dirty-rate (provided my comment in an earlier
> patch) such that if you try to get a dirty rate included the IOMMU invalidations
> marking the bits accordingly.

We still have the "if (!migration_is_running())" check above, so 
non-migratable VFIO devices won't sync.
But that's a valid point for when we'll allow VFIO log syncs for 
clac-dirty-rate.

>
> Just stating the obvious in case this was non intended.
>
>> -    }
>> -    return true;
>> +    return vfio_devices_all_device_dirty_tracking_started(bcontainer) ||
>> +           bcontainer->dirty_pages_started;
>>   }
>>
>>   static bool vfio_listener_skipped_section(MemoryRegionSection *section)
>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>> index 9ccdb639ac..8107873534 100644
>> --- a/hw/vfio/container.c
>> +++ b/hw/vfio/container.c
>> @@ -131,7 +131,7 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
>>       int ret;
>>       Error *local_err = NULL;
>>
>> -    if (iotlb && vfio_devices_all_running_and_mig_active(bcontainer)) {
>> +    if (iotlb && vfio_dma_unmap_dirty_sync_needed(bcontainer)) {
>>           if (!vfio_devices_all_device_dirty_tracking(bcontainer) &&
>>               bcontainer->dirty_pages_supported) {
>>               return vfio_dma_unmap_bitmap(container, iova, size, iotlb);
> Reviewed-by: Joao Martins <joao.m.martins@oracle.com>

Thanks!


