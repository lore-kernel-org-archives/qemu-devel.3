Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD996CCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 11:33:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDLSu-0000Ef-Ug; Mon, 27 Oct 2025 07:32:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1vDLSV-00005C-A0
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:32:30 -0400
Received: from mail-southcentralusazon11011026.outbound.protection.outlook.com
 ([40.93.194.26] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1vDLSJ-0003O0-Km
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 07:32:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LDrrE7qBeKC9vUagBnIcxeyYEpVti+qO8YWuh8zGBYBqkIhNKJjLfaaQktqy/jC+DeZJG81G6c09kBRoXTngTDcjAIUtKrLc7eZryemyZ1fIcZn6O3QXSQguN/ZX49g3FRmDRjgZM/Oh5TU+S0v8gO2ar9ibhV30U2CZp97twkRHduN8hs8/PchQzBe01T1cicHLFVcLCFXLa7Gn1voPc3C1NpxcBBFZ5ielM+ZptGdxcUOFL4lRO4S8fuOdn9yjY63dZ/qNuMX98PDdqEZrf39EJK8Bb49OkJPIQSYx81R4gHBTZH7Ia84Ryx0EMo0zmANLfchBt35Ba4c8W/1PRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xqer8IpkXt8OyODCYLOTbt6URKIxmbdVK5XbXpDvqk0=;
 b=xEUkjPf/xPRrtGig0TpPpC7UpT2UUQaDKejGF3T3UH7BCmoB0DS7PHqPZcEq1OgsmSVrw+gD2nAoK2Ah/dm40ZpBqOdybM6jHznTDlBzvHqnk/fztjzD4DfRv+vK8S6gN0SHTIYMkoW8nLd/mqryjxcfKfWT6wKXKwlh5ao5c2I2nguMDdoaQ9HDu+HVal+2q24WbmE48tpby4YCrrH5eIZ9FNlHFc5YpjIb2iVpzXv0bAY37UGus24FwshfCd7TFpBd9qyTMhT32znrb3GKTKRhu9z9AXeVxkuG/eD+4t7xVInGqgVfEmf9DCLLYgsVH+qffLXglNLDmlYEgIk29Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xqer8IpkXt8OyODCYLOTbt6URKIxmbdVK5XbXpDvqk0=;
 b=l7lS1cBpomWbAcR6MtLWBWkfvRIyBWqVzHQu3B14Pgj19uRrdXs6gv8DBhFSv1LHw7hY5cxaYRi0nvbFcEYSOWhymiIGNfGGYG6E8ZQJKeiovkkfEhnoH1XdKkAyrv3q2bmOHPeR8nYEki1UmWr6/bMR/Y7DA/QH5SK2U/wWuq4unjdOkOKZ5xyElAhhZXlzT8aPRyO9hCp/QBXpXisVbvZEw0WET8V8i2ZC448GkVDRXhu0cSS5CRtXhfxmCr2YhQ9Cow3xob7U+slDpwI25WFO7CNOMRskPkCvmjBMEAprdNUF0YXVRVXWHcwq3M5qVqud0kT04dmJzjLZF3GY3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by SJ2PR12MB9087.namprd12.prod.outlook.com (2603:10b6:a03:562::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 11:26:53 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%7]) with mapi id 15.20.9253.018; Mon, 27 Oct 2025
 11:26:53 +0000
Message-ID: <df474b7c-b210-43ba-9c0f-97526aaf5f93@nvidia.com>
Date: Mon, 27 Oct 2025 13:26:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/8] vfio/migration: Add migration blocker if VM memory
 is too large to cause unmap_bitmap failure
To: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, clg@redhat.com, mst@redhat.com,
 jasowang@redhat.com, yi.l.liu@intel.com, clement.mathieu--drif@eviden.com,
 eric.auger@redhat.com, joao.m.martins@oracle.com, xudong.hao@intel.com,
 giovanni.cabiddu@intel.com, rohith.s.r@intel.com, mark.gross@intel.com,
 arjan.van.de.ven@intel.com
References: <20251024020922.13053-1-zhenzhong.duan@intel.com>
 <20251024020922.13053-8-zhenzhong.duan@intel.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20251024020922.13053-8-zhenzhong.duan@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TL0P290CA0015.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::7)
 To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|SJ2PR12MB9087:EE_
X-MS-Office365-Filtering-Correlation-Id: ae750df8-d3fe-4420-4e20-08de154bba8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d3JGdjFNeU9lRzM2YXNKS1hzSDVVMXlnZzBybXdad2YwSlg3amhZSVA1NzJG?=
 =?utf-8?B?aU43UW5PWTFjU04zL21yZmhyZDFRZkhZNjMyTTlWTjFWWXN5dkxWbjFDWkpJ?=
 =?utf-8?B?cEpKaURxUWwzK3RxcDNQeVpISXpYbElKRnp5VlltMzZZQ29BM05RS3VqNnJ6?=
 =?utf-8?B?S3BjcXQrdUZSMy8rMWllNzFtNTdHRktBVGxrNEtWTE5DREVYY0dmZmxYVzBG?=
 =?utf-8?B?WlZVSDh4VG9oeDdnNHdnaHB0MlFkUGRUR2dkMzlkNGRFOHUxSlNpNCs4OS9h?=
 =?utf-8?B?MmFKanFWbENhaVpsaEZ4OGtlYnBNTHBnOHRpZUt5ZU5mRFNuL01QSlg2cFVw?=
 =?utf-8?B?V0tTRnk0TUdmWW1vODBpZVZWb3A0YnRQS29SY21BV1lsdDRZRnVldFQyVCt6?=
 =?utf-8?B?YS82R2FPU1ZmM3VQUXBFRHBrRkVVeCt2UVp3dTZSS3l4WFNLc3pWbXEzMDNC?=
 =?utf-8?B?dm9zWnliYUJuQmt0bmxxRzgwMXcvbnlLdzVxSGQ2Y1BhRGFOMkkvdnYzNmZV?=
 =?utf-8?B?K1NQVy91WXJkWGRjS1RlYlVXZDVyb2Q5elBqZFhBR3JEV1VIZ1JqQXJzeDFE?=
 =?utf-8?B?YUNhVDZsMThqZ2xGaXNmd29BUHR2QzFsOTZPNTUzenVqeVhLbUpTOCtUU2hl?=
 =?utf-8?B?d29PeGloZlRRRHhSOHdjcGR4WU5KVVBNclNaUlBZbEhHYnZERlU0dXMxcHFE?=
 =?utf-8?B?MGV3NXFvcUMrVFN0b3RQRUpOM2NxbGw1QThsemFucUZjVDhYUEw5YmRZempS?=
 =?utf-8?B?ZGo4OHpoanpoTmlBSVFtWmVUdEJ0RDlEam1XWDZ2UWQ0TWIrNTJodGJtM2cx?=
 =?utf-8?B?Ykxtc1REVXVscnJaSzdncDdpTG9uOXlTQnEwQ1BpRmtJSUhINTdlNFNpOFZB?=
 =?utf-8?B?THI3RUxpQ3ozM1ZkOGNhTDRiSU0xRXhvTVRpdEJoMW9qUXk4ODk0Uk5XRS9w?=
 =?utf-8?B?anAyV05INGJPYTdrelZ3c3VORWJWdk9EWGE3N3FmL0NPRWdUcUREM1RzeWF6?=
 =?utf-8?B?ZW5jd285eWJybjRxYktIU29NTXk2OUF2ZWRXUE9BZFM2cVpSMXMyaW5wQTB0?=
 =?utf-8?B?UHFKRlM0OTdvK2Z3M09iUVBDMGpOVkVMcWVSTFlIK2k3TmZGdnQvNzI5WWMv?=
 =?utf-8?B?UTVSRGt3VUpORnZRYjBlN3lrUHBDUEd3NHlXbzJvNzlHaitnSnFWWFZlQ3Zh?=
 =?utf-8?B?TTF0M2l2L3VXenlYZHBjdWhTY2pJVGVhYWZUUzdicHQyc2Nicy92bU1HNDRs?=
 =?utf-8?B?U1RKWVZHR2JpNzBZYU8xM3NRanhrUU5oQytaaUZOaFVPSDFWNWJlTERzUXNP?=
 =?utf-8?B?eDRIVFcrTjhZcnlUQnJOWVJiVTY0L3RkeTlBbkZhL1c3WnFUV0cyMzZ6MmtZ?=
 =?utf-8?B?VWwySjZMd3UwY2J5UUE1UEZpV09udS9kbmJTRkFrOWlPOTJNRFpReWdQY3lL?=
 =?utf-8?B?OEpvMFlSdWlGYnVsQ1BWbFdRVllFZXppV09lampybE5CT2FRbjBmMGp4Myt5?=
 =?utf-8?B?NnJTd2gyWWZtcWY1OFdkK1lMdGE3anB6TDlkL243L2hGMkp6MjdCUXhIcmwx?=
 =?utf-8?B?M1FMS0JEc1hZb1V2b05oYis1QVN1STc2UXR2SFIzMzRqV3ROcnE3ajBmM1JV?=
 =?utf-8?B?WHBiazl5V1hjR0tlNmxHTTh1TEFzc2g2UHIvSi9VN3Y4OVNHREJrVnB4VC9E?=
 =?utf-8?B?VjRnS1dETmUzZlhrSytXVG9tY1NSN0preXhndWlzTjFDWXUwdFA4K2VHV2FY?=
 =?utf-8?B?WHRDWkVTUUhXdTRDV1ZvSFlpUWp2YUlpMk54WXAvU2ZPSWMwWmNxMDNiZUUw?=
 =?utf-8?B?WThHb0pIcnB3YUd5ZmxZNUVhUDFEbExNWG5WeWNXN2lCY0M2MUdzUStKRmpH?=
 =?utf-8?B?c1ZTemt2bkp1bml0TWJKR3Zzbjh0emNBNUdKVnk3MzgvMWVnc2tVMWdNR1lR?=
 =?utf-8?Q?RnYSxc1LlO7JvVDFxNHDWJApgBPkCq68?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ti82dlRuQUw4R3NzUHE0OW5xdElZcEFGRzNNNjhHZklrLzFsQTl3M3lqRUU0?=
 =?utf-8?B?TzJFOUJIbEVRN0UwV0wrVThBckMvODQzQzIzL3dZMEJZdzN6TGZEMktkZ29W?=
 =?utf-8?B?RjNhSmFDbkNoSEtDOGN3QUVTNVFvazZpMHdPblltYitZYjdjRngwYkRnSU9W?=
 =?utf-8?B?TVBsV1pQOEJYTHlXcTZJblJjMGJraEFTMXpEdVM2clllZURTVWNZVVZ6Yldq?=
 =?utf-8?B?RGU4dCtuTFhMZFpUNVd0SnpBb0ZmYUgzU3ZIVVdna1lmYmxGNnRMeHorOTZt?=
 =?utf-8?B?eXFjYkp5T0k0VUMxYjRjWDJFeitVODJHb3JNNnZXSkh5elpYdEJMVU9LbDRG?=
 =?utf-8?B?S0JFL2NwZ3B2MThOeFRRUFI0T0loM3NUdE9YeFp6VXNtNStjUWs4bzlNVnZ4?=
 =?utf-8?B?UStJY01taUR5OHVJVHhvUXVmeC9mMFptVGo3cGllcmRvd0dSVmcvVXI2VmpQ?=
 =?utf-8?B?SXdIT2M5MEN6RUhpOXd6d0twUWZMYmE4MExhN1dTZ0U4SnlIUE43bHJRU0pj?=
 =?utf-8?B?TE9NTldma1dDUnBWcDRTazlrS0x2TGNpMUROdHd1SUxkUkVBMzdMUHJRSmpK?=
 =?utf-8?B?UDJSMTkzS2E2eTBVTzZ6Z2ZaYkwvaWNtNnBVWXR1b3h5YkVOWE9mZmFBc2FJ?=
 =?utf-8?B?THFlNldIZ09WN0J5a2FqTnNRWHduS0FzYXdTSTVPNyt4bEk2VnBOdDhUUEZ2?=
 =?utf-8?B?WjNkVlVEcWpDei8vTHg2aC9ldnYxRFB1bGhRUkhERWUvVmg1bW1CSEdYQlNq?=
 =?utf-8?B?QmcvNnVYbCs3YXFxNFpOL2hCS29pZmdxMDVyVi9qL0xmUGNLaEkwYkROaWVQ?=
 =?utf-8?B?NG9lRlVLS0FrUDFWYlp6NFNIMFFFV2NCeFVYOGFVUEpKbXpjV3lhME5EUlVZ?=
 =?utf-8?B?YkpKcnk3UlpaVk9ieCs3U3NRV3ZVVWpIZStrZkhORmtnb0NpRFZ5NEhGYWR0?=
 =?utf-8?B?MlNrQ0lJUGRJZE9VRHdRODBZcHBrQ0JEVjM1dmw0aWNsZ3dBNXVLNGd2ekZr?=
 =?utf-8?B?aFo5ZjJ2dmNwWlJuck1PUHBZdi9KWEx4akt5UDdQMDJLVzFXY2llTkR0bUc1?=
 =?utf-8?B?enFvWlRWRnFrRTkxUVNac2VWdDBKWk5TUXpiWGFXWmU0a28zVWIyelh0Vlhk?=
 =?utf-8?B?c0JxaXBLazRrSTRpdXlJN3NobjFzWjFYZUdBbUdzakI5YWdwL2ptUEQ3Qm9K?=
 =?utf-8?B?NHNvT3NtVzFYUG5wWXlBR2VuenNiL0pPQXBjN1hzZmNzMUVIejZGYllRaDR6?=
 =?utf-8?B?NVpaaWU4SUJIdCs5RUs5REFlL3FzdUF4bkphYUJhaXI4OU9qTm5VMzlDR2ZM?=
 =?utf-8?B?VzRSMnRtSU1jY2p1WHBaSkZxVWluSWtWMld4UlN0RStDZWZTNjNSTXh0bkJm?=
 =?utf-8?B?SVpSNHVVTGVFUHZwT2pYNEh0c0l2aDhqY1RMUUF6cE15MU9xbkhLaXh1VGM3?=
 =?utf-8?B?RC9PV1RSaVBYOTVPNVpxeDUrUGY1NkRDN2N2MXQ3aXpEYXUyeVBhZ1hEVXBo?=
 =?utf-8?B?ZDNrQ3JxRzB2QWdnRTE2R0g4K0tOTEhFOXR5TWM3czk5RUo4OGMwbWhvU3FJ?=
 =?utf-8?B?SUtKaDg4dCtnbzUwT3FOek9CaWtqa0JTbXRqRkIxSVkvNWFzSHBYOWtCUDVW?=
 =?utf-8?B?WVdZRnRISjlXaDlEbFBaeFpObXBTbTJqa3dyR1J0U1M4YTRTOHJoVXk1WGZF?=
 =?utf-8?B?ZE4yRG8vL1oxSmM0Ri9UVVBja1VuWFF2ZFN3blVocGpQQncyLzUrYUx3dXFR?=
 =?utf-8?B?NjFFaDVYTnIrN3FTNnJKMyticEpGdVFIMDVRT2p6MVRpaXJKTUhzTXJqSTd0?=
 =?utf-8?B?MmsvekNZbUJlZU1PYTkrZXp3eEI5TzBrYWJVaFE4M1J6Sk1MWUF3M1lpNmt5?=
 =?utf-8?B?QTJnVWQ0VjBabXdieGhNZC82RDNhQlhxZ1hlelNzcHg0M05GUXBPcHlwUWpD?=
 =?utf-8?B?MlJhdTNSeDlqekJKdXdGTFVQRExZOU92VkFpMTFiUzJPZm0rU2Jza0lVNEJM?=
 =?utf-8?B?SFRnc0pzUTRZZTFWWFlEeWdxL05oTDlvMGVKN2gxWTNiR0xBOTgyQjZMMzEy?=
 =?utf-8?B?UjdDMnROdDYyZHpocGVmdGU4U3Z5MzFMcGgrTUc2YmFFUGkzeWlYVGxDQmxk?=
 =?utf-8?Q?fuoRWWFpNB6eJQH9bmOAD07nf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae750df8-d3fe-4420-4e20-08de154bba8c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 11:26:53.2576 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8zucCKffMK1i7ifNkaDdmEiRbnOwGyBU4lCuPD/oNmoCOvQDhNItyN7bw7XhBpWPC8leM0ntn6VRBxhsGKTWpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9087
Received-SPF: permerror client-ip=40.93.194.26;
 envelope-from=avihaih@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Hi,

On 24/10/2025 5:09, Zhenzhong Duan wrote:
> External email: Use caution opening links or attachments
>
>
> With default config, kernel VFIO IOMMU type1 driver limits dirty bitmap to
> 256MB for unmap_bitmap ioctl so the maximum guest memory region is no more
> than 8TB size for the ioctl to succeed.
>
> Be conservative here to limit total guest memory to max value supported
> by unmap_bitmap ioctl or else add a migration blocker. IOMMUFD backend
> doesn't have such limit, one can use IOMMUFD backed device if there is a
> need to migration such large VM.
>
> Suggested-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> ---
>   hw/vfio/iommufd.c   |  5 +++++
>   hw/vfio/migration.c | 33 +++++++++++++++++++++++++++++++++
>   2 files changed, 38 insertions(+)
>
> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
> index ba5c6b6586..8de765c769 100644
> --- a/hw/vfio/iommufd.c
> +++ b/hw/vfio/iommufd.c
> @@ -633,6 +633,11 @@ skip_ioas_alloc:
>       QLIST_INIT(&container->hwpt_list);
>
>       bcontainer = VFIO_IOMMU(container);
> +
> +    /* There is no limitation on dirty bitmap size in IOMMUFD */
> +    bcontainer->max_dirty_bitmap_size = UINT64_MAX;
> +    bcontainer->dirty_pgsizes = qemu_real_host_page_size();
> +
>       vfio_address_space_insert(space, bcontainer);
>
>       if (!iommufd_cdev_attach_container(vbasedev, container, errp)) {
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 4c06e3db93..44bab024b7 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -16,6 +16,7 @@
>   #include <sys/ioctl.h>
>
>   #include "system/runstate.h"
> +#include "hw/boards.h"
>   #include "hw/vfio/vfio-device.h"
>   #include "hw/vfio/vfio-migration.h"
>   #include "migration/misc.h"
> @@ -1152,6 +1153,31 @@ static bool vfio_viommu_preset(VFIODevice *vbasedev)
>       return vbasedev->bcontainer->space->as != &address_space_memory;
>   }
>
> +static bool vfio_dirty_tracking_exceed_limit(VFIODevice *vbasedev)
> +{
> +    VFIOContainer *bcontainer = vbasedev->bcontainer;
> +    uint64_t max_size, page_size;
> +

IIUC, this check is not relevant when using VFIO device dirty tracking, 
so maybe bail early if VFIO device dirty tracking is used?
E.g.:

if (vbasedev->dirty_pages_supported 
&& vbasedev->device_dirty_page_tracking != ON_OFF_AUTO_OFF) {
     return false;
}

And replace this with vfio_device_dirty_pages_disabled() in patch #8?

Thanks.

> +    if (!bcontainer->dirty_pages_supported) {
> +        return true;
> +    }
> +    /*
> +     * VFIO IOMMU type1 driver has limitation of bitmap size on unmap_bitmap
> +     * ioctl(), calculate the limit and compare with guest memory size to
> +     * catch dirty tracking failure early.
> +     *
> +     * This limit is 8TB with default kernel and QEMU config, we are a bit
> +     * conservative here as VM memory layout may be nonconsecutive or VM
> +     * can run with vIOMMU enabled so the limitation could be relaxed. One
> +     * can also switch to use IOMMUFD backend if there is a need to migrate
> +     * large VM.
> +     */
> +    page_size = 1 << ctz64(bcontainer->dirty_pgsizes);
> +    max_size = bcontainer->max_dirty_bitmap_size * BITS_PER_BYTE * page_size;
> +
> +    return current_machine->ram_size > max_size;
> +}
> +
>   /*
>    * Return true when either migration initialized or blocker registered.
>    * Currently only return false when adding blocker fails which will
> @@ -1208,6 +1234,13 @@ bool vfio_migration_realize(VFIODevice *vbasedev, Error **errp)
>           goto add_blocker;
>       }
>
> +    if (vfio_dirty_tracking_exceed_limit(vbasedev)) {
> +        error_setg(&err, "%s: Migration is currently not supported with "
> +                   "large memory VM due to dirty tracking limitation in "
> +                   "VFIO type1 driver", vbasedev->name);
> +        goto add_blocker;
> +    }
> +
>       trace_vfio_migration_realize(vbasedev->name);
>       return true;
>
> --
> 2.47.1
>

