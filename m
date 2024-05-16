Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C18C25B79
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 08:25:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7WQj-00078g-RH; Thu, 16 May 2024 04:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s7WQf-00077x-H5
 for qemu-devel@nongnu.org; Thu, 16 May 2024 04:25:33 -0400
Received: from mail-mw2nam04on20601.outbound.protection.outlook.com
 ([2a01:111:f403:240a::601]
 helo=NAM04-MW2-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <avihaih@nvidia.com>)
 id 1s7WQc-0000Ct-J0
 for qemu-devel@nongnu.org; Thu, 16 May 2024 04:25:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HU66iIxENKxbDOeAmT+ywGSc4zptCIpZTP21x3m6qP3OXcq9JHgV8JFHyctIsSqcxcMFW5Os4tBP913D2Ta03xTHu8Q/pOwWMSiWXH+G20oW4XmzMM0L85YWBUSz4JqsG3zdiq0zfgMpZrORZBJPJiUx9N3Vc++I666brOek8g/UoFcOHoNOgZwsFHct4ExRt9z+w/dOhiSFCHEhNrRZyG7Y3M34yhR7+71rIYFKlrjQH7e8exCw4L0JP1wSFdvUaMsW9CZmA7QCqHNmUJW8FHyK7yjZtU9GSeOpYoxoZt1RgHhPyTCYROSilMfH0QUwzU4NWh+Ww9T4eBQRhIDQJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6z4bVvYRxY0uLjRSuWHxxlE1POo3/xLAEFkGNzAKdVM=;
 b=bsigZ4CLwEdbPEVUiP5g8Anodcf0IseYmbfgeVpHg3ils3BZFfCIhfto/JT3XOy+WwYgY20+BFyfkFTcMW/Oj3U1NnHGUWNHQHUcWCgYhKevjj5U/cAaa2uDiVAW/QrCbDIGMKdfZt1EAAcZT+1Icd0Wggy1eXtrVZN9gf7K9dmSa7vsG5706FsfvnlEI87qHtbp8MLUkWV/Wavn4Q7oU7MAfhfL1e/IBkIHsfIb60CB+HaMw2QPPrfkEmGiqjWbScaHuVMHgW1pVxXXIjDt0UGJFx3vgVcuJIft3tkkyrKLI9+6OrBhGqC3HpwwkNThpWHoK5cCmJRcbFKBFzV4Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6z4bVvYRxY0uLjRSuWHxxlE1POo3/xLAEFkGNzAKdVM=;
 b=B/Zk/bG4wbA62D/z7JSSsfx+ePtVxFlNixilFHLa3YD0fxirxopWtGesVtwfO9Z426PfWW3YjWvP4cfBTixAfUTDlH6sud6fdXJsKf2fwB7w6cdfJBIR0t2mhi3aUpoVmGrz1KXXxlRRkJA1LJIGqG8aoXTdrt3pgXKQjjdqI+mDaFOyWPIwTTAl5RPm/7T3zY7VBnuaN8ceX11vkgOYVzy86aPxaJeZGMbb0+ky/wyJ6mnWxns9zz/3trKHWV0tyyrZzm2ZzvmFPFX0x02A1ZtXZ4CLwmtS6SJ/nTmUaHP7/7cNp/mNNU1xQ83yw/cI3EKVo3YGJPMqAE0Ktbmt8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5549.namprd12.prod.outlook.com (2603:10b6:5:209::13)
 by SA0PR12MB7461.namprd12.prod.outlook.com (2603:10b6:806:24b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Thu, 16 May
 2024 08:25:24 +0000
Received: from DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91]) by DM6PR12MB5549.namprd12.prod.outlook.com
 ([fe80::e2a0:b00b:806b:dc91%5]) with mapi id 15.20.7587.028; Thu, 16 May 2024
 08:25:24 +0000
Message-ID: <b2b53c92-75b1-4080-8221-ddb6f34e3768@nvidia.com>
Date: Thu, 16 May 2024 11:25:17 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/9] memory: Add Error** argument to
 memory_get_xlat_addr()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, "Michael S . Tsirkin"
 <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>
References: <20240514153130.394307-1-clg@redhat.com>
 <20240514153130.394307-8-clg@redhat.com>
Content-Language: en-US
From: Avihai Horon <avihaih@nvidia.com>
In-Reply-To: <20240514153130.394307-8-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO6P123CA0014.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::17) To DM6PR12MB5549.namprd12.prod.outlook.com
 (2603:10b6:5:209::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB5549:EE_|SA0PR12MB7461:EE_
X-MS-Office365-Filtering-Correlation-Id: becc57a2-7d77-452a-f07b-08dc7581bc0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?KzZ6Z1FOTHRVYXpvTjdzajJZQ2lFMnZTNkRmKzhSdmtsbUl1OHZPN3ZvSUpm?=
 =?utf-8?B?d25LTjlObC9pc3R0MDUwTHh0RlkwM0tNamk0YVQyb3VBeGUzVERVSkllVkFr?=
 =?utf-8?B?U1JpNHBLdW5KVmgvWEt2ei9xQ2ZSY0I0QzFYTXkzOTFTOFZPVzRLU1dIUGZX?=
 =?utf-8?B?azlPVmljNXBESElyZjZTTjBVTmNURUlUSUFTVkpOVlF1cHlTVVFrZGFScVdW?=
 =?utf-8?B?UjNTT3d3dS9WV2ZMdkFjWlJrQUpVaCtaSi80MTFFbGZrUHBIbTlSc3VyODJx?=
 =?utf-8?B?SEpta0JUaFJ3TXVGL20xY1VTdS9pZ0lDcHN6Wi9IZGhCWDROZTM3VFBOK1NE?=
 =?utf-8?B?SzB4U3JqbE9xWEJlb0VRUUx6bFQrZ0lFTWhNbWNNYTJoMUxtRXFDNnk2YkRr?=
 =?utf-8?B?SGNrWkpGR1RIZXhWR3NXdlRlSnUrREI0cEI2dDN1ZlN5QTltZFE4bStxeThz?=
 =?utf-8?B?bzNPOFhrMmUreXplWElKQjVUSU8weUJUV3B4anMwVkI3NHpuSEJrc0ZudXZ4?=
 =?utf-8?B?cUNVOTdYUmdMbWl6eWh1T3NLSmwrK3FBYWl3UjB4ZTNVc3c0R3R2QUl4VUhw?=
 =?utf-8?B?a29TcTVNTDRuK0xscStybUVvYndZb3lYblVXUm9SUWY1aUxDSUF1L2pIMXRw?=
 =?utf-8?B?d2N0ODBZZTJCaW42dWYzMkxZQTZOa05FenlHSXpyM04vRWo2K3lCYS9TbVo2?=
 =?utf-8?B?QmpzeWdNNXZJYngzNlkvbi9nN1dJVlJIMzBaeFcrUjlMRTc1a0R5YjYyOHNV?=
 =?utf-8?B?TkFzMCtldEgweTlIQUtVb0tRRitrYzlYeFBUT200b044SmEyS2ttTlY4Slpl?=
 =?utf-8?B?TE5ZUUsrMnNlOStPU2Q2N0dDS1RMcm5DekgwaS9FNHBQQlpjMWRCckpYUjhJ?=
 =?utf-8?B?YkYrUVJ3a2tjSElJVmUxK0VpTHA1bVlyK01yc1p5T2JoOW5sQkdmRkdzbGFK?=
 =?utf-8?B?WkFaUVlyWWpwMlN2SEt5RXdrUm9xMjFwTXYrenIrZzg3ZHhGQnd3bTdLdkI2?=
 =?utf-8?B?MWRsaWluWGtCNXFtVUdoRG1kSnJHUzRQeVJJVUM5S0ZLT3MrcFZHM014S3Mw?=
 =?utf-8?B?Uzh3ZGxNSXVYT3N0UkZkeXE4N1pkenROSmd1ODlzZS9lY1RJYjN6TDd5TFFz?=
 =?utf-8?B?b2VHcWxlaUpDMm5QRXJObVo5QndaSkEvN3k3MXhIU1RPci82VlBHNUhHRGZy?=
 =?utf-8?B?ckxubmNSdWE0bk0wblVKV1pDMi8yNXpVVTQ2RHhOcjdFOVdKTi9SUjlEV3Uv?=
 =?utf-8?B?NitjTnVoMit3c1VUWWU4WVNGem5yZUVJS1pBSnMrc2pZZ2hFaWt4UGgwSGp0?=
 =?utf-8?B?SjA1b1p0VFcwcXFaWVhmTkFJakU1SFZ5NjgyZmNWcG82VWR2NG1lS1JONm9l?=
 =?utf-8?B?NkIwR2hvb2RNVW5qTDF6dEZ0b0o1SkNEVXpFNldNMjhhK295VXpWVEM4bmlh?=
 =?utf-8?B?S2pXeXRYeU1udm1qMzRpZjdOMm4wOG1xdVZnRU1aS1B0NHlWM25PZStkRVFR?=
 =?utf-8?B?eDJGeldQeEF3bCtvK2FhdkNGTDV1TzNIbHFiVXNSZFp2eSsyOUJjNzlEbm12?=
 =?utf-8?B?VVFHLzJmTjB6WGZDMC9LTk9VTklmbzFRTEtxS09mOXRtcUhCRW81UldOVzlY?=
 =?utf-8?B?LzU0eEFmckJQeVpDMmtEVzFkSkxIVXVocG1xcXhRemJMUDFmZDNEeHp2ZzRs?=
 =?utf-8?B?M21DdUFqMWRGS3Q0NnNReFF2bDJJcWZnM2dzQUt4NjJrSmtndUpOTU1BPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB5549.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005)(7416005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkZ1bCt3Z3ZpMVEyUjN0UjV0TXJoTW95VjZ5M3l5dXJDQWtyby9GR2FUYWJn?=
 =?utf-8?B?ZEdua3hVQ0xONzBNZ25SdG9WNi90M1cwSmVra1NRS052VnA5WVF1d05Keno4?=
 =?utf-8?B?Sit2VjdtODVRRHFhNUp5ejFCbEMrZXZuMUs1YTVCQythUUxWY2dReWpzZVl3?=
 =?utf-8?B?TXlTSFBMdHlZdFo0cU1BRFNYczdTRVNWOEthQlVTb0F0SEpXWS8rdWc2bkI2?=
 =?utf-8?B?a21MTDQ4elNEV1kvb1ZXbzJuWm9yR2hGUXJaL1ZTazZpV0dycXJ2bzJCQlZt?=
 =?utf-8?B?cG9oZmFmak5DMW5MWFBETWV1RThEZzFHSGhVME1GdHRvbWFBNmVUQXdwTzUz?=
 =?utf-8?B?bkZCNlg2RDIxU1hqckRJbEFCNWdocW0zY3ZhOFl2N1VSQ1VFZy81MXFQbmxZ?=
 =?utf-8?B?Mm4zZXF3K1pmcloxY2ZhMmRsTEJwNm10TVZzMG1xZld6dGhyeEtBT2xpN0FV?=
 =?utf-8?B?NGg5bnk2dlc1ekhwYnNFRlJxMm5FS2RMMW1hSk1LbldJY1FZRmdIcFZPOEFt?=
 =?utf-8?B?WndvM1RUaC9USUJsb0ptdk9KZldDWVNGa04vV2Q5R3dwSkQ0SWtoT3Z0R1Fk?=
 =?utf-8?B?cWRMREdFU3phakd1MUlHaHpibUxOd0ZqMHhOMWVkUEhWTm5oTTRFck5lSENT?=
 =?utf-8?B?RW9keThxYkYzTnFjVHhMSTdiOTZMNlptNUJtLzJJbW5xbTVRcUE3RGtnNk94?=
 =?utf-8?B?V3ZlS2RJd0Nsd3V4UWxuM0JwdUJMd1drWGZTdTNSMjZIQXV1MGN3K3g4a3hE?=
 =?utf-8?B?MVYweUU5cTNFTU0rNWVlajR6UE9XdFJPdEQ3QkVML2RUazF6NWNpam8wSU1h?=
 =?utf-8?B?eEJnQWJnMm5ZTm11ZGlqZm54Y2FQWW5nanBRbGdQNmFoaFJRekNieUZ5d0JY?=
 =?utf-8?B?WWcxK2ozQjZPVENYaVdCKzJZalRuT0tFN3VtSWlYeXdZc2owT3R0YytPbmRp?=
 =?utf-8?B?ZWU2K29FWUNwQnFsK1BRWEg0VE9wMU5vc3Bja0QvbkdxUWdCNXFRRHJ2enBk?=
 =?utf-8?B?aHFQZ2o4OFd1RzRibThzUlAvejF0VHNOVjZNU2ExcFJEMGpTMFJwYXQvYWpI?=
 =?utf-8?B?MFRycmNWK2tDVmIxVTBCSE9XQkpHR2FXSlUrV21FNXVLYVJqMVhEd0RjQ0pm?=
 =?utf-8?B?dlFPVW1tTHlyYmtNcHBjLy9zZGRidjZaQjRuV2VodEJIYlpXVFRjcHoxaEk3?=
 =?utf-8?B?Tmlmdkp2aDA5ZitnMGh0eGk0S3prRllMSXMxSElzUXpOd1FWOTNDVnBadFV6?=
 =?utf-8?B?SXB5cER0RUgwZ29aNUNNYXJpY05iWDJuZDg1R1lYOEdUMlljeFpJVDRyaE9w?=
 =?utf-8?B?MVB1OWVpd1FQU3lHZ3p3SWcxaFZaRlRvbCtlcDA2alVZQ3dObldBYmo0Nzg2?=
 =?utf-8?B?a3I3N1JJRVJzd2JtZ0owL1IvNzUrT0NibkZWVXovdnpVOTN6YjZOVjNIbGJS?=
 =?utf-8?B?TjNoRHFWWmhTbVdWTkovQStDdDI1NjgwT24yb0xNcHpRQ1BZQVNTcmFZNVpa?=
 =?utf-8?B?MVk3WWhlT2tBSnd6dDRacFhtS0l1d2JPRXBSTzBCcy82WGJndnhUMWdXdXJV?=
 =?utf-8?B?cWtwTFpGTmlOL2VmM2VVWGVodUlOWXFHcisvbUJmalNnQUc5a05GWWpkTEpJ?=
 =?utf-8?B?MVlEN3JIWmFWaVYxYi85ME5OOVpGSmwwSjd2WUw1eStIY3BtNklISlVuaERi?=
 =?utf-8?B?SjBjUFY0aVlyMS96Z0RETENBa3JDV3V1R0JubjA1amdPQlVZR0taeWpvMTlI?=
 =?utf-8?B?Wm1uRXpQcjZEOVV2a2t1MUpzMC9JWDFUeERnK1RucG1mWjgweXdQQ0MrcHpV?=
 =?utf-8?B?MjdFR1c4ck54V3oxd1I3VnVQdUVWUGtJYVhDTWsxNklMeTQ1aWRmdHovcHJX?=
 =?utf-8?B?aGhHYmVMMm5VMUVyT1Vjd3UyYlRFY2plUzFkdmUza2huandIVGZ4M0hKS0Fy?=
 =?utf-8?B?K1JTSmRwVGR4YXpMYy9OVVMya1VQSXRsVmRLN0lRK1dxdVZzemhUMjU1bjJ5?=
 =?utf-8?B?WENjWjNmTlBFSzk5RHZhK3Y4TGQyaGpVLzNoejFVUEtaWXlDUFVIb2cvSnhC?=
 =?utf-8?B?T3FyL1RyK3NoY1NROFc5cGVyV3BrWjR0MlNLeVQxV2t2Z09FLzR2MmN0MXpp?=
 =?utf-8?Q?Ljz/LL4MIAHRl01pNTCkl5C/x?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: becc57a2-7d77-452a-f07b-08dc7581bc0d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5549.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 08:25:24.8051 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2JQ0Jw9OxXN3tzc0utw9hOq6ZkNyES30cpUz2BosYTIfNJj3B50j3qoAYo33US0Qkc3TRx6cPIbrpRjwCqpPCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7461
Received-SPF: softfail client-ip=2a01:111:f403:240a::601;
 envelope-from=avihaih@nvidia.com;
 helo=NAM04-MW2-obe.outbound.protection.outlook.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.935,
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


On 14/05/2024 18:31, Cédric Le Goater wrote:
> External email: Use caution opening links or attachments
>
>
> Let the callers do the reporting. This will be useful in
> vfio_iommu_map_dirty_notify().
>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: David Hildenbrand <david@redhat.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>

FWIW,
Reviewed-by: Avihai Horon <avihaih@nvidia.com>

> ---
>
>   Changes in v6:
>
>   - Fixed memory_get_xlat_addr documentation (Avihai)
>
>   include/exec/memory.h  | 15 ++++++++++++++-
>   hw/vfio/common.c       | 13 +++++++++----
>   hw/virtio/vhost-vdpa.c |  5 ++++-
>   system/memory.c        | 10 +++++-----
>   4 files changed, 32 insertions(+), 11 deletions(-)
>
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index d417d7f363dbbca6553c449582a93d5da73cca40..9cdd64e9c69b63f9d27cebc2e8cb366e22ed7577 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -774,9 +774,22 @@ void ram_discard_manager_register_listener(RamDiscardManager *rdm,
>   void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
>                                                RamDiscardListener *rdl);
>
> +/**
> + * memory_get_xlat_addr: Extract addresses from a TLB entry
> + *
> + * @iotlb: pointer to an #IOMMUTLBEntry
> + * @vaddr: virtual address
> + * @ram_addr: RAM address
> + * @read_only: indicates if writes are allowed
> + * @mr_has_discard_manager: indicates memory is controlled by a
> + *                          RamDiscardManager
> + * @errp: pointer to Error*, to store an error if it happens.
> + *
> + * Return: true on success, else false setting @errp with error.
> + */
>   bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>                             ram_addr_t *ram_addr, bool *read_only,
> -                          bool *mr_has_discard_manager);
> +                          bool *mr_has_discard_manager, Error **errp);
>
>   typedef struct CoalescedMemoryRange CoalescedMemoryRange;
>   typedef struct MemoryRegionIoeventfd MemoryRegionIoeventfd;
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index 4e2ef3d3034e72aa6a546bcb9ea1f31a0bbd5b1b..919c4c52bc1590fd6c0bda37ba5881f58ff2ffff 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -253,12 +253,13 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
>
>   /* Called with rcu_read_lock held.  */
>   static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
> -                               ram_addr_t *ram_addr, bool *read_only)
> +                               ram_addr_t *ram_addr, bool *read_only,
> +                               Error **errp)
>   {
>       bool ret, mr_has_discard_manager;
>
>       ret = memory_get_xlat_addr(iotlb, vaddr, ram_addr, read_only,
> -                               &mr_has_discard_manager);
> +                               &mr_has_discard_manager, errp);
>       if (ret && mr_has_discard_manager) {
>           /*
>            * Malicious VMs might trigger discarding of IOMMU-mapped memory. The
> @@ -288,6 +289,7 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       hwaddr iova = iotlb->iova + giommu->iommu_offset;
>       void *vaddr;
>       int ret;
> +    Error *local_err = NULL;
>
>       trace_vfio_iommu_map_notify(iotlb->perm == IOMMU_NONE ? "UNMAP" : "MAP",
>                                   iova, iova + iotlb->addr_mask);
> @@ -304,7 +306,8 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
>           bool read_only;
>
> -        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only)) {
> +        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, &local_err)) {
> +            error_report_err(local_err);
>               goto out;
>           }
>           /*
> @@ -1213,6 +1216,7 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       VFIOContainerBase *bcontainer = giommu->bcontainer;
>       hwaddr iova = iotlb->iova + giommu->iommu_offset;
>       ram_addr_t translated_addr;
> +    Error *local_err = NULL;
>       int ret = -EINVAL;
>
>       trace_vfio_iommu_map_dirty_notify(iova, iova + iotlb->addr_mask);
> @@ -1224,7 +1228,8 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       }
>
>       rcu_read_lock();
> -    if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL)) {
> +    if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL, &local_err)) {
> +        error_report_err(local_err);
>           goto out_unlock;
>       }
>
> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
> index e827b9175fc61f1ef419e48d90a440b00449312a..ed99ab87457d8f31b98ace960713f48d47b27102 100644
> --- a/hw/virtio/vhost-vdpa.c
> +++ b/hw/virtio/vhost-vdpa.c
> @@ -208,6 +208,7 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       void *vaddr;
>       int ret;
>       Int128 llend;
> +    Error *local_err = NULL;
>
>       if (iotlb->target_as != &address_space_memory) {
>           error_report("Wrong target AS \"%s\", only system memory is allowed",
> @@ -227,7 +228,9 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>       if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
>           bool read_only;
>
> -        if (!memory_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, NULL)) {
> +        if (!memory_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, NULL,
> +                                  &local_err)) {
> +            error_report_err(local_err);
>               return;
>           }
>           ret = vhost_vdpa_dma_map(s, VHOST_VDPA_GUEST_PA_ASID, iova,
> diff --git a/system/memory.c b/system/memory.c
> index 642a449f8c867d38c62a748a4dfd5c055637c205..9540caa8a1f4da8501bf5ae9d7eedde8b775e1dc 100644
> --- a/system/memory.c
> +++ b/system/memory.c
> @@ -2179,7 +2179,7 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
>   /* Called with rcu_read_lock held.  */
>   bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>                             ram_addr_t *ram_addr, bool *read_only,
> -                          bool *mr_has_discard_manager)
> +                          bool *mr_has_discard_manager, Error **errp)
>   {
>       MemoryRegion *mr;
>       hwaddr xlat;
> @@ -2197,7 +2197,7 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>       mr = address_space_translate(&address_space_memory, iotlb->translated_addr,
>                                    &xlat, &len, writable, MEMTXATTRS_UNSPECIFIED);
>       if (!memory_region_is_ram(mr)) {
> -        error_report("iommu map to non memory area %" HWADDR_PRIx "", xlat);
> +        error_setg(errp, "iommu map to non memory area %" HWADDR_PRIx "", xlat);
>           return false;
>       } else if (memory_region_has_ram_discard_manager(mr)) {
>           RamDiscardManager *rdm = memory_region_get_ram_discard_manager(mr);
> @@ -2216,8 +2216,8 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>            * were already restored before IOMMUs are restored.
>            */
>           if (!ram_discard_manager_is_populated(rdm, &tmp)) {
> -            error_report("iommu map to discarded memory (e.g., unplugged via"
> -                         " virtio-mem): %" HWADDR_PRIx "",
> +            error_setg(errp, "iommu map to discarded memory (e.g., unplugged"
> +                         " via virtio-mem): %" HWADDR_PRIx "",
>                            iotlb->translated_addr);
>               return false;
>           }
> @@ -2228,7 +2228,7 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>        * check that it did not truncate too much.
>        */
>       if (len & iotlb->addr_mask) {
> -        error_report("iommu has granularity incompatible with target AS");
> +        error_setg(errp, "iommu has granularity incompatible with target AS");
>           return false;
>       }
>
> --
> 2.45.0
>

