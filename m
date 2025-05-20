Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C6E3C3DA6D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 13:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHNFJ-0004tD-OY; Tue, 20 May 2025 09:43:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uHNFH-0004sy-Cf
 for qemu-devel@nongnu.org; Tue, 20 May 2025 09:43:03 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uHNFE-0002aE-Cm
 for qemu-devel@nongnu.org; Tue, 20 May 2025 09:43:02 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54KCtv34014420;
 Tue, 20 May 2025 13:42:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=0erExDrY4meV5blWCLuIDdq1LbmA4HwtTMiUfay4yzY=; b=
 GNE5yvFUpKE6/xb/AyaV2j/5BKcASJlm6FEgLTESMFSpAT1Gh7VYXE8GOB8OwU6Y
 43Xjj9ufoRgsrTXTN+hZm9XDjXdybgl96VqCOCw44Z0cAX8MxNO5DjGQhRt7JQot
 E3QbnMtelKoz39zthnh0wNEPUTsN5HWUdvo9obmH0OPIAHlJGabvvq0w4Z1xrmou
 Cj7CwN0assOArdMFlzKJLceX5rskGj+ZTzHJVxARhyq6G2NfuA3eUAZtU9JU4uJK
 3HdHtdX+f448t9L5JtC2iJNGM5+cBWx4ZCdexNYnRz3xX2jxl/NvxPmug3NXYgLV
 VgP8vJp22yYAW06d2MJp7w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46rdny9bxh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 May 2025 13:42:55 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54KCOGDd017470; Tue, 20 May 2025 13:42:52 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com
 (mail-northcentralusazlp17010003.outbound.protection.outlook.com
 [40.93.20.3])
 by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46pgw8915v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 20 May 2025 13:42:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PXEo6q3mhxtrbNpvJgbf6Ul6ViCDCvMoNhGM9sTPmxxfvtvDCgmPBY0b6XxG4VnAp0WgNhVVE4s3OnrtOIfESyMM/dXHoSEWD8WLI1WjSdBQ1lc5xJp36CN1nzm2DDutN+TxiizD+g6LjlPOjHdhnZrskXFWX/B6UKpcY9Brv4BtcD3iPE6ZpOtlvzptaTuRuTJ6fMctf2NYWf093mnAf5+RdSuuMhYVDdk4IRilBAyTfsmpwxm9znoJtXn1Y0r1xV90ZIbJQtGGFz1h3/RxECye7QkZbP87mmmJaqDYT+9FZFLS8HB/i9nIX0ggZ7WVCTpGAKNrHmeT+/JwQPNM+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0erExDrY4meV5blWCLuIDdq1LbmA4HwtTMiUfay4yzY=;
 b=bPx4pA/5N/rURasy3ymSTxDnUCEBw9OLjmRz8VdB9s09dLw0z5Ydz7eSOhGUZfLxa24h9hc5llwP1obRD1gOfZ0VKXKe3lbDo6lMTy2V+vc/p3xklMpIkKGpPQzM3JK+HAZELXwtbcEMJJQY62uNRj4gwsu0JMAWoj3EZtDg/FyPEmFNlWwdXpb7hVTf54ImZXs86DL/6eOhstY6pgBpNTkiMcYHmmGvJAIVsWbH3Sbc3JNSfZD3k3B+436T1S2ff2Qn4ZjGGD//bNcvVIO8Gi8D9iIQfD0/beWhXgFg4amJnKe0YhZqk8womgBHhN68HTFlNxYEm5GXhqi7TNjfrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0erExDrY4meV5blWCLuIDdq1LbmA4HwtTMiUfay4yzY=;
 b=AYsqT7VGJnyr9DCqUbezJfdM2YKAyIytsXPJBgpbnRNOLxlJPMxLYOXROnJgnzSMA8qlIT1u6pJhFz/MaF11TzoDJ/tpRHfct87M00LsZs+UHj8Nia80wvLrvYHXzJ6g/+OVUNivGPa441hP6InbUNMLwo0OqWitDp4fyHfVPFc=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SN7PR10MB6306.namprd10.prod.outlook.com (2603:10b6:806:272::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Tue, 20 May
 2025 13:42:49 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 13:42:49 +0000
Message-ID: <ef48d347-b36e-4442-b97e-bea284eab1ac@oracle.com>
Date: Tue, 20 May 2025 09:42:42 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V5] vfio: return mr from vfio_get_xlat_addr
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Alex Williamson <alex.williamson@redhat.com>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 John Levon <john.levon@nutanix.com>
References: <1747661203-136490-1-git-send-email-steven.sistare@oracle.com>
 <bad3129a-8470-415e-8e85-0238b3ef1b26@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <bad3129a-8470-415e-8e85-0238b3ef1b26@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR21CA0001.namprd21.prod.outlook.com
 (2603:10b6:a03:114::11) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SN7PR10MB6306:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e018d1c-1aa3-48bb-521b-08dd97a43596
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZDlicmFBL2RyRzgxd2o2ek1namZvdmhkZ0FUK0NLcm1wMWdGem44aURGOFN5?=
 =?utf-8?B?UG90TTBRNk1YOWZpSU12VitLWnBIdWR2QUtqZlN0WXhERWJ1UG5NQlQxOTRF?=
 =?utf-8?B?VXR1RXFLSmNqcWNtWGtLVWlLcnROb292dDF6djhhMVluSEgzd3hXRFBXRUNJ?=
 =?utf-8?B?YjM0SWNtRWVmWXQ0bFhrTndqaDZjdVo2UTVqLzNJZmdBTk5mV0ZObzBBMG83?=
 =?utf-8?B?bElwbnV2NUUxYzBianBZWmVwL2VlY1hWOFB3Y3czZitlek5kdXFIS2gxWjE4?=
 =?utf-8?B?QjEyNVNYbnV2WVZVNWpndy9JMURUV1B3MG0zSFpSRHUyYzJ0R0JQSmVRNDR6?=
 =?utf-8?B?TFIydU1SU2dqbUhaN0tuaHBtb2lodFNLb3JKZUUrUHJIaERDdnNzV1BIMWpm?=
 =?utf-8?B?WVdUUU9LSW9rNWp5MjFKakpkbFoyRmNBVmt4QzdQcXVJSW5YaE1GK1ZsRENX?=
 =?utf-8?B?WktrRWsyLzErb3RyWWRQR01sVkc1cWVENkc3VmhtbXdOelpCdzE4WFREK2hw?=
 =?utf-8?B?QXNFYTREUDFFTlhKa2FNOE90NGdaaDJDdnIyZ29XYmNBVUthMm1seEJNeVd6?=
 =?utf-8?B?Si8vcEJJNjdOY1NnQ2czK1JvdHB0bm9zZXo4dUpIbTE4dHo4eFN6a1d5NVRW?=
 =?utf-8?B?UFBuZkNRVUVtd2ZxUFFuWmU3ZlJHSU42SUJZdTV5ZnM5d1RKUzBSQmV4c25C?=
 =?utf-8?B?blQweXRPWURkOE1rMjg2SHRJa0hiYWdoVWFTdS84dUg0NjBKdnR1VDJKMnpG?=
 =?utf-8?B?dVNlWVd3U01TdWJRSUNxazg2NzlacjI5TllBZWpVOE9la2FmR2VQZ3ZjMFRC?=
 =?utf-8?B?T3hmYU0va2N5SUNINkVnY3loK09LMWsxZnVhVFRnMklQYmpqaEVTQzNTeGpQ?=
 =?utf-8?B?NWpUbithQ1U4MmJRYjhBU3h2cGpXMm04Nm5USVBnS0IydU9FVnc2dHVNa2Ra?=
 =?utf-8?B?M3RTOE1ZNS92MGI0WVN5eCtXM1UyL2xDV1dEOURMZHk4ZmZOYXgyYStEUFNE?=
 =?utf-8?B?RTJEYm0wZ1Y2NVBIdDljcmRPV3VtTnVNcnBHZDREeVNrT3VpK0RDMUZ1SGg2?=
 =?utf-8?B?MEwzZjFmZ0xIVk53YjVZVXY4dnAvdXcxVThQajdTRVpNaDh2dHdVWkZiSndC?=
 =?utf-8?B?dUtJV3dsMWs5d09JV1RsSWwzM1hvVC94akxNZnhZSDlVWjgxNW1WMkdBaHFQ?=
 =?utf-8?B?a0paZTBaZ25YcXg1R1Q3ejFvdXAreXVRNlFBTUV5SHVYWGhLZkpBQm16Kzh4?=
 =?utf-8?B?QlkxUytHZU9SY3NBYjN1eUVaVDRWejNETmR0cDYvRmR1aXFtTURHREZMWk9W?=
 =?utf-8?B?UkNrTTljZmw1eUtFTk5YTlBiMGJUelluMWZFSnBHOGRSZml5NUZhdFNMSGxT?=
 =?utf-8?B?WHJSZU51NzBFNkVzbUJzcVJndERZNlNDcVRpdEtKSlJlODljeWo5U1gyRTBL?=
 =?utf-8?B?UWd4OHVBbUMxdTVHdHovM1VTZDlqMm56TnNWNVNUdTJXZWVTUWZJaExubTVD?=
 =?utf-8?B?UVRFTUZjck1lUXk5djBKZHQwejI2ZmRTbGhOZGp4SXdrdU0wQW9QaG5YZktu?=
 =?utf-8?B?VXFwNTliM0hCNGIrQTZJenI1ei9CM085TW92MmhZOUlMeEc1TnpJV1ZQbGdZ?=
 =?utf-8?B?a0JiQ1lTVU9vV3dxNW9RUWtnVWZFUHdEcE5ycG4xNVNkOWl0Vnp1dTBlZEpo?=
 =?utf-8?B?WjhyR3NlRit3d1NGL2pTVWdiWk1Qakh1ZWk0V3oxRWxlVW9Nb0diYW4rMVRD?=
 =?utf-8?B?TDBsamNFK3JOT3Ard0Z1NFFaaEFFa1loSGE2YllGTjZhTmJrUlp0OC8zL1Y1?=
 =?utf-8?B?cyszcWNMYXp1TnBrNUFUVURDTDlRMnMyNW9GS0M5Q0hTM1QrR1EyZVVoYXV2?=
 =?utf-8?B?SWZSbldvVzdxdjRnbUM2YktPWkhFZ2llVGFGdmNuS3RMUWNGL094eG1OSkY2?=
 =?utf-8?Q?1Mx1B+p0F4A=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TnZ3QlF5cllwdUYrYnByVmdXZXR0cmRLMitnVE5QWFlhS2wxdlN1VUhZNndF?=
 =?utf-8?B?aWYxTlRXTVZWVkVTUWM5c3VjVEdqR2RUZzJRc1VkUFJDUkk2RTd6ekMyYnpN?=
 =?utf-8?B?SEx4aW4xQW5UQU1WTkVKM2ZaOEtXdFUyaHdWN1lTNVc4QnZRYjJLQ1NCWTZO?=
 =?utf-8?B?bENZeFNWUFFhQlZlcFp5MlNmSW5PandvaDBKY2RudmpHdnNZaWxpVmxnZjZn?=
 =?utf-8?B?dk9FTGIwOTNGN093Z2xjRGViRXc5azhBa1NzMW9yQVZiQVVzd2I4QnE5M0Q1?=
 =?utf-8?B?QW1VZUdNRU1LbDZSUVBnamFqV0FveVRMbythZTdvWURUU1NDTk0rbjgvcldj?=
 =?utf-8?B?eVFJM1lXNjhSUmVyM0k3dTk2OWdsTE1jeWlLRDljbUx1dEVwV2R6MWREaVM3?=
 =?utf-8?B?ZnczZUMwbUhmMVQvRXlBSWU2eFZFNVdpTDlXMUlHNGVUc3lKWFBuWHZnNWJD?=
 =?utf-8?B?M1pMcE80VWxXSGVjekdZVXAvQkU5Y0NlQ0tXb3BPZkU1S0k1TkdEMFRmTFRu?=
 =?utf-8?B?MEtUU0tLL3BVTVI3dVhiM1pBSDRzV201eFlSVzZtRHcrOUx0OXhLN1VvNnVZ?=
 =?utf-8?B?c1BFZEFaNHByaS8rSEx4UVdJNk9qOFdDNGFscW96MmR2RWRNRVZEc0pjNCt5?=
 =?utf-8?B?MHBneTJUSVJJRWkwbG9DNGVVUkR3VTBMcGFFU1VYNElUckgvSy9hdlpIZTJq?=
 =?utf-8?B?Vnp5SjNGUnVZSnlybXUxTjlqNFVJV1drM1pKU1dFUkgrWDVSNFlmVnFhUVow?=
 =?utf-8?B?Y2ZMREFGSVlrK3NmS3pDN1d1aUJiM0lYU0t2TFdDM3VncjgwRllZUlRQcTEv?=
 =?utf-8?B?ODRkbzQ1R3ZGTHpNMFVuVlplaDM2N0xYODFIRGdQRlAwZXQzQkE5ZjZMOWRy?=
 =?utf-8?B?M0xCdTBxSWc4aDlYb3k2WUhLQzc4Qit1TENsRDE4M0ZIMS9FWC90SzNIRkM1?=
 =?utf-8?B?WXNvdWpQTnlEbm1rY1MzS0tQZnpPd0V1MGRRaVZEelFVRUVQVUF4Q29GWTRq?=
 =?utf-8?B?ejFiUjBLWUFxMmJIOG9NbTJ4RDZBd3FXZjdod3RUaTFJc2w0RFhCeTYwV0hE?=
 =?utf-8?B?dThYeU1FemZhZW51WUFhd2JjdTU5Yi9RTldXeUw1RzBVMGN2Q3g3emlJSzgw?=
 =?utf-8?B?RzFSTE1rQzRQaExTcnJCYjVKZ3pkeVU1RUUvMFRVaE03NmY5ZnJYcU95K2ta?=
 =?utf-8?B?RDVkUlowVHFIcldHWjdKdStFT1BFOGhjVGZrNUtIZjdYS3ExR3ZVVHhWZlJ1?=
 =?utf-8?B?ekhXc2ovRWpjQWlVZkhwMkRRcFFtMXJJVnU5N3hlazZ5SFZCaWV5aWlUOG5i?=
 =?utf-8?B?QzB0SmNlclNCOVFzWUVuV3V2VFBGM1VYTWhMVHZscE9JQ01haWdTQlVDa0x2?=
 =?utf-8?B?aXV2ME9kNnBIQktjbks3S2p4WC96ekpSOVc5SndqQjFFWnFXNHYycFg0YVFT?=
 =?utf-8?B?RzZMdXR6bzhsc0lBSm5LRmEvQ0Q3b2ZHZGJBcHRnRUsxaHpQaXVWWFczS05R?=
 =?utf-8?B?bS9uUEFES1BYUk11SGhaN3FBSncxVDFGV1YzY0RRMTZqS1BhZWFYbk4rZlla?=
 =?utf-8?B?NGp1NHYzWXNsdTVXZU11bkFxS2dFRDVCSGIxKzFGTG9WMHdPUU9zcWwwaHBv?=
 =?utf-8?B?Z3lOMitiamxKa1lORkFXeURlU083a3FvVEdZMmJRbFhLeU5kdkRUQjU0dVRI?=
 =?utf-8?B?eEMwNVo3bXdJZi9ueVZkbnR3VTlJc0tIVmJINTJEc1dpZmovRjY1YTcrZ2VU?=
 =?utf-8?B?RitmTlJ3Y1ZJRWhNRk9wRW83SDhYbytUR2YyTGNpRGJIY0ZDcFBkaE92d2ZW?=
 =?utf-8?B?Sk1HQ0E1M0p4c2V0Qi9mMjI2YTNHT3JLRXhmdkVsK3RlcWhGY3R0WlpMYzgz?=
 =?utf-8?B?cmgwMVJ0Sm5qNmRyUnI3UjlqUkE1WE83VHdxYUMwZlM0QWxybVlyQzB6cFI0?=
 =?utf-8?B?dHlnNndsbVlyelFSNWJUU3d3UlRLQ1Bwb1BkU2VmQUoxRmdPamJmcGdJV1p6?=
 =?utf-8?B?N3lKZ1pEaHpjcDFocnZvaUtjNG1aTE5scnYyQ1VyRS9WOHNGWG12MGs3TmNi?=
 =?utf-8?B?eGVPczJ5VUFDZUJsajRPWmk2aWU0ekNSMFlrTVd1c1FOak41TkVEY1lldTNO?=
 =?utf-8?B?YkUwVS9RenIydXhpWS9aNzNEZnBjK3RlZ2lTMGlXeUVXTHZNU0NXc2hSbEZF?=
 =?utf-8?B?cnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5KcYvMiKr8vvxWceF/hl237oNrpUdM92xvN/xeZDaqG0Kzxc04Q1nYjLjaS5VtSN/NSVpCoPwR0wdRxkl1UPwDL5rr1uFpWLZkFkCe3qpW8TUFSLfrPxJJtaAEVTuFnjgyD9s9ICCOrc5G3JvPaguDP5LjbjzipWLB/g1py/Pr+XCE3xmyrlXXEnn0q/b2ySyVeFKzmBqmN+2Zbj/g0/BBdLXArrfmNZuMIOSqag4CnMP9nSxaLgJfWE3Zw57PJHZRNz+8AG1PzF1zyJ+3apsG3ao9kyXgLjv/jxLpSYk4dyCQcnO6P+wqXxm12YW+3dmkGweLG76PyKsNHTwUJ2vQqPTXSHCXIn8Uze1cPDoo4n9ga19yB298HEicf2QWlSTAY2RFZJZazdW8qOlg7AFYgRsU3sBGAeNZh2LliciEMksCYZgdsVUqdkN2MIIfZouPJH0Km3OSJNQj5QESLgqhjBOlgg5KVOvXB59EdNVoDzhi10iCoorzGR0nNyJ8E0zpCde/0XlJaYR+7mU/SbITH8iiqqHDd/P2ofJ2aEJQ6cioGmgqnIwYEQkzMQw4t8roBbYtDZuJ5QM08ucNUhx+OWdPvLXjDPaqhRLtDQWL4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e018d1c-1aa3-48bb-521b-08dd97a43596
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 13:42:48.7589 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cj70oJoEZWrHoWvHnTR453vDIbY+WeIZx8avnlQqHA/9zSxuYNHvXk/wLXZcpwSSwzOGfW/HRXnjH+6UAyuWfo/ItTWzGCdMsUwrPl89s+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6306
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-20_05,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 suspectscore=0 spamscore=0
 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505200109
X-Authority-Analysis: v=2.4 cv=S93ZwJsP c=1 sm=1 tr=0 ts=682c86df b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8 a=0MWoUGTY9xpSrIvhqOoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13188
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIwMDExMCBTYWx0ZWRfXxPoi47rytCjP
 AzlcvIOLVs2ec0ov0k8pDzp9QNEMOSao6tIxmhJ3H3xUGhHM2kDE4W+Waf0pv6ZvRLYz8n7GIas
 sTYyZjaEl0Fo+OODbhtb98zg4ORSToFm5flm0mKBoMMCZhIoS5rR7ZjBL2/jv0LZEZeawOEzgjW
 4o72RN8tEM3adMJz4f1s7+iTNPl4Ks6MleYnoNenZ/EuZT8bFRa7hWmzqi5xp3AzbeVdb4XKhJZ
 SH8aV/qc/bD+aEQm1wQGyQmt2Xt9iivrBE9WB2bC2aKtVJ/1xNb1ecSpdhMgTMN6/tOX9gPqmHB
 ZtgVhAanJOOZzUfHnuqXdXwzhLBYtKRBTb29TTTRUXczdYgA5h+kTVIRw6YCT3gaysCHDteKUpY
 ZM1MKx3JlBgfRLceiFjCn4fs9m63TloZoAth0pnPcvRMquHCsLjSPtIzJ3h3I2S2PR+QpXc8
X-Proofpoint-GUID: geoVb0NOeSfJcJz92jlj24ocXAr4A4Ti
X-Proofpoint-ORIG-GUID: geoVb0NOeSfJcJz92jlj24ocXAr4A4Ti
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 5/20/2025 3:32 AM, Cédric Le Goater wrote:
> On 5/19/25 15:26, Steve Sistare wrote:
>> Modify memory_get_xlat_addr and vfio_get_xlat_addr to return the memory
>> region that the translated address is found in.  This will be needed by
>> CPR in a subsequent patch to map blocks using IOMMU_IOAS_MAP_FILE.
>>
>> Also return the xlat offset, so we can simplify the interface by removing
>> the out parameters that can be trivially derived from mr and xlat.
>>
>> Lastly, rename the functions to  to memory_translate_iotlb() and
>> vfio_translate_iotlb().
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> Acked-by: David Hildenbrand <david@redhat.com>
>> ---
>>   hw/vfio/listener.c      | 33 ++++++++++++++++++++++-----------
>>   hw/virtio/vhost-vdpa.c  |  9 +++++++--
>>   include/system/memory.h | 19 +++++++++----------
>>   system/memory.c         | 32 +++++++-------------------------
>>   4 files changed, 45 insertions(+), 48 deletions(-)
>>
>> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
>> index bfacb3d..0afafe3 100644
>> --- a/hw/vfio/listener.c
>> +++ b/hw/vfio/listener.c
>> @@ -90,16 +90,17 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
>>              section->offset_within_address_space & (1ULL << 63);
>>   }
>> -/* Called with rcu_read_lock held.  */
>> -static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>> -                               ram_addr_t *ram_addr, bool *read_only,
>> -                               Error **errp)
>> +/*
>> + * Called with rcu_read_lock held.
>> + * The returned MemoryRegion must not be accessed after calling rcu_read_unlock.
>> + */
>> +static MemoryRegion *vfio_translate_iotlb(IOMMUTLBEntry *iotlb, hwaddr *xlat_p,
>> +                                          Error **errp)
>>   {
>> -    bool ret, mr_has_discard_manager;
>> +    MemoryRegion *mr;
>> -    ret = memory_get_xlat_addr(iotlb, vaddr, ram_addr, read_only,
>> -                               &mr_has_discard_manager, errp);
>> -    if (ret && mr_has_discard_manager) {
>> +    mr = memory_translate_iotlb(iotlb, xlat_p, errp);
>> +    if (mr && memory_region_has_ram_discard_manager(mr)) {
>>           /*
>>            * Malicious VMs might trigger discarding of IOMMU-mapped memory. The
>>            * pages will remain pinned inside vfio until unmapped, resulting in a
>> @@ -118,7 +119,7 @@ static bool vfio_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>>                            " intended via an IOMMU. It's possible to mitigate "
>>                            " by setting/adjusting RLIMIT_MEMLOCK.");
>>       }
>> -    return ret;
>> +    return mr;
>>   }
>>   static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>> @@ -126,6 +127,8 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>       VFIOGuestIOMMU *giommu = container_of(n, VFIOGuestIOMMU, n);
>>       VFIOContainerBase *bcontainer = giommu->bcontainer;
>>       hwaddr iova = iotlb->iova + giommu->iommu_offset;
>> +    MemoryRegion *mr;
>> +    hwaddr xlat;
>>       void *vaddr;
>>       int ret;
>>       Error *local_err = NULL;
>> @@ -150,10 +153,14 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>       if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
>>           bool read_only;
>> -        if (!vfio_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, &local_err)) {
>> +        mr = vfio_translate_iotlb(iotlb, &xlat, &local_err);
>> +        if (!mr) {
>>               error_report_err(local_err);
>>               goto out;
>>           }
>> +        vaddr = memory_region_get_ram_ptr(mr) + xlat;
>> +        read_only = !(iotlb->perm & IOMMU_WO) || mr->readonly;
>> +
>>           /*
>>            * vaddr is only valid until rcu_read_unlock(). But after
>>            * vfio_dma_map has set up the mapping the pages will be
>> @@ -1010,6 +1017,8 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>       ram_addr_t translated_addr;
>>       Error *local_err = NULL;
>>       int ret = -EINVAL;
>> +    MemoryRegion *mr;
>> +    ram_addr_t xlat;
> 
> xlat should be :
> 
>      hwaddr xlat;

Will you make that change when you pull, or do you want me to submit a V6
with this and the RB's?

- Steve
        trace_vfio_iommu_map_dirty_notify(iova, iova + iotlb->addr_mask);
>> @@ -1021,9 +1030,11 @@ static void vfio_iommu_map_dirty_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>       }
>>       rcu_read_lock();
>> -    if (!vfio_get_xlat_addr(iotlb, NULL, &translated_addr, NULL, &local_err)) {
>> +    mr = vfio_translate_iotlb(iotlb, &xlat, &local_err);
>> +    if (!mr) {
>>           goto out_unlock;
>>       }
>> +    translated_addr = memory_region_get_ram_addr(mr) + xlat;
>>       ret = vfio_container_query_dirty_bitmap(bcontainer, iova, iotlb->addr_mask + 1,
>>                                   translated_addr, &local_err);
>> diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
>> index 1ab2c11..a1dd9e1 100644
>> --- a/hw/virtio/vhost-vdpa.c
>> +++ b/hw/virtio/vhost-vdpa.c
>> @@ -209,6 +209,8 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>       int ret;
>>       Int128 llend;
>>       Error *local_err = NULL;
>> +    MemoryRegion *mr;
>> +    hwaddr xlat;
>>       if (iotlb->target_as != &address_space_memory) {
>>           error_report("Wrong target AS \"%s\", only system memory is allowed",
>> @@ -228,11 +230,14 @@ static void vhost_vdpa_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>       if ((iotlb->perm & IOMMU_RW) != IOMMU_NONE) {
>>           bool read_only;
>> -        if (!memory_get_xlat_addr(iotlb, &vaddr, NULL, &read_only, NULL,
>> -                                  &local_err)) {
>> +        mr = memory_translate_iotlb(iotlb, &xlat, &local_err);
>> +        if (!mr) {
>>               error_report_err(local_err);
>>               return;
>>           }
>> +        vaddr = memory_region_get_ram_ptr(mr) + xlat;
>> +        read_only = !(iotlb->perm & IOMMU_WO) || mr->readonly;
>> +
>>           ret = vhost_vdpa_dma_map(s, VHOST_VDPA_GUEST_PA_ASID, iova,
>>                                    iotlb->addr_mask + 1, vaddr, read_only);
>>           if (ret) {
>> diff --git a/include/system/memory.h b/include/system/memory.h
>> index fbbf4cf..13416d7 100644
>> --- a/include/system/memory.h
>> +++ b/include/system/memory.h
>> @@ -738,21 +738,20 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
>>                                                RamDiscardListener *rdl);
>>   /**
>> - * memory_get_xlat_addr: Extract addresses from a TLB entry
>> + * memory_translate_iotlb: Extract addresses from a TLB entry.
>> + *                         Called with rcu_read_lock held.
>>    *
>>    * @iotlb: pointer to an #IOMMUTLBEntry
>> - * @vaddr: virtual address
>> - * @ram_addr: RAM address
>> - * @read_only: indicates if writes are allowed
>> - * @mr_has_discard_manager: indicates memory is controlled by a
>> - *                          RamDiscardManager
>> + * @xlat_p: return the offset of the entry from the start of the returned
>> + *          MemoryRegion.
>>    * @errp: pointer to Error*, to store an error if it happens.
>>    *
>> - * Return: true on success, else false setting @errp with error.
>> + * Return: On success, return the MemoryRegion containing the @iotlb translated
>> + *         addr.  The MemoryRegion must not be accessed after rcu_read_unlock.
>> + *         On failure, return NULL, setting @errp with error.
>>    */
>> -bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>> -                          ram_addr_t *ram_addr, bool *read_only,
>> -                          bool *mr_has_discard_manager, Error **errp);
>> +MemoryRegion *memory_translate_iotlb(IOMMUTLBEntry *iotlb, hwaddr *xlat_p,
>> +                                     Error **errp);
>>   typedef struct CoalescedMemoryRange CoalescedMemoryRange;
>>   typedef struct MemoryRegionIoeventfd MemoryRegionIoeventfd;
>> diff --git a/system/memory.c b/system/memory.c
>> index 63b983e..306e9ff 100644
>> --- a/system/memory.c
>> +++ b/system/memory.c
>> @@ -2174,18 +2174,14 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
>>   }
>>   /* Called with rcu_read_lock held.  */
>> -bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>> -                          ram_addr_t *ram_addr, bool *read_only,
>> -                          bool *mr_has_discard_manager, Error **errp)
>> +MemoryRegion *memory_translate_iotlb(IOMMUTLBEntry *iotlb, hwaddr *xlat_p,
>> +                                     Error **errp)
>>   {
>>       MemoryRegion *mr;
>>       hwaddr xlat;
>>       hwaddr len = iotlb->addr_mask + 1;
>>       bool writable = iotlb->perm & IOMMU_WO;
>> -    if (mr_has_discard_manager) {
>> -        *mr_has_discard_manager = false;
>> -    }
>>       /*
>>        * The IOMMU TLB entry we have just covers translation through
>>        * this IOMMU to its immediate target.  We need to translate
>> @@ -2195,7 +2191,7 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>>                                    &xlat, &len, writable, MEMTXATTRS_UNSPECIFIED);
>>       if (!memory_region_is_ram(mr)) {
>>           error_setg(errp, "iommu map to non memory area %" HWADDR_PRIx "", xlat);
>> -        return false;
>> +        return NULL;
>>       } else if (memory_region_has_ram_discard_manager(mr)) {
>>           RamDiscardManager *rdm = memory_region_get_ram_discard_manager(mr);
>>           MemoryRegionSection tmp = {
>> @@ -2203,9 +2199,6 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>>               .offset_within_region = xlat,
>>               .size = int128_make64(len),
>>           };
>> -        if (mr_has_discard_manager) {
>> -            *mr_has_discard_manager = true;
>> -        }
>>           /*
>>            * Malicious VMs can map memory into the IOMMU, which is expected
>>            * to remain discarded. vfio will pin all pages, populating memory.
>> @@ -2216,7 +2209,7 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>>               error_setg(errp, "iommu map to discarded memory (e.g., unplugged"
>>                            " via virtio-mem): %" HWADDR_PRIx "",
>>                            iotlb->translated_addr);
>> -            return false;
>> +            return NULL;
>>           }
>>       }
>> @@ -2226,22 +2219,11 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>>        */
>>       if (len & iotlb->addr_mask) {
>>           error_setg(errp, "iommu has granularity incompatible with target AS");
>> -        return false;
>> +        return NULL;
>>       }
>> -    if (vaddr) {
>> -        *vaddr = memory_region_get_ram_ptr(mr) + xlat;
>> -    }
>> -
>> -    if (ram_addr) {
>> -        *ram_addr = memory_region_get_ram_addr(mr) + xlat;
>> -    }
>> -
>> -    if (read_only) {
>> -        *read_only = !writable || mr->readonly;
>> -    }
>> -
>> -    return true;
>> +    *xlat_p = xlat;
>> +    return mr;
>>   }
>>   void memory_region_set_log(MemoryRegion *mr, bool log, unsigned client)
> 


