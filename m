Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA7EC2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 13:02:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHj49-0000Rm-UM; Wed, 21 May 2025 09:01:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uHj3z-0000P1-A8
 for qemu-devel@nongnu.org; Wed, 21 May 2025 09:00:52 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uHj3v-0006YW-B8
 for qemu-devel@nongnu.org; Wed, 21 May 2025 09:00:50 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LCqToD017933;
 Wed, 21 May 2025 13:00:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=Mfu8jRxzBnQCNpzIx5CYzDEiInIJA1YZtE3f6o6eFgE=; b=
 cSerdyaEBN5CVmNxp/hOfwYnY8HDQX8x0VyBRyGOjYp/AuZRhBeTVTz+oluKMofe
 FUUQQsAMB2Jw29yj2+KxJBcEDJglJp67U7M+G9/50ZFT+Ul0i+nP+2AHlyJixCqK
 /WQeICwUkKMlk63Ek/eLvWbYfzzbFWg+Jry6J/SrEd4jVSRDLNGWHCGd3aE2QrsT
 5JBpLIScUOpofh1lhK/OGXIOONif9rGhtvGHPQ3jferl1PdFXUaESsGCxxVw4muv
 Uqu7Wv5bVvVZ2ePvPEAaoAy0BWzUlTEgoIYEFUwk32i7DRCT5u6yU1pHX52eYHl+
 EVs1CuOVrnrrktveDk6U+w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46sf7c80x3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 May 2025 13:00:42 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54LBtf7L011349; Wed, 21 May 2025 13:00:40 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46rwen2v3v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 21 May 2025 13:00:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gHqbS0NjwvU3sbWPVO8rMCU6Sz6jk7/aow5Iw+ZX9AwMTven7jZKVXFkxd6KvKBYQ08XCnfGu8VkvydkdsV669PD076moO8pcW1JqQOw2nPfiOZKyABddtnsz1S5M/HDgM4kDp4GcBCNTZkmoihClRZy0KQPBuqJZdS9NFHaJ/qcHU2S7ArxXi8LvEOWOz0cHpZmVSfSS9WaUHZnu8e5kzetNMJX+pK17pesOkWOI9K7CM6OeFMF84ZmBxAXOD4A/7JZXSoi4N+CaKEae2KV1j41fVgugiJNUgUQ7qrxqU0E44+uVAJsMEn8/F5FJ9vBCYoyxIbOMHrcSfilN3eoSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mfu8jRxzBnQCNpzIx5CYzDEiInIJA1YZtE3f6o6eFgE=;
 b=wB9wGUyeotYE2QINpPm3XeK6ohVSlDobgzJrff/6Ych8MpKg+tUMQn64y1F3/9O8B6Yz62KrPhyOb3EWTCa6L8GExJihEpwkoS1cG1N8gj5NSJ92lVx77VOSnf+llRq02ErXDTRwo6S9EYmHy4wVLO4vrCzlg2TWvxVF1nBmh46Ml+mBD4Xy21lBtGoe89hNUm0WlKv3JaoG1sUP1OMn7Kv1j4xcaedJ2qN/PKScbAcTRCDrDsipYYL4a7iq+muYyyr+4ERTuXCWxikKH+fKySmUw3f0+6lOMcmwaWMvtmZt2DeCe8A0qfm94Jdh5iv0uerWwEdvz7Lj+R0RYIIdwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mfu8jRxzBnQCNpzIx5CYzDEiInIJA1YZtE3f6o6eFgE=;
 b=0KMBOMH+t5SaAF5ksFo0qOBzOxhiVdBOj+mQRAig1UDDQjAcRznVf4fom1bqkR+AQ88Y1BrQerKuLzWcfw0GL66lXnlDorZQ9aQDAZcw7KB7dHNwPHlZ9QkBOZK3e985jvjGSlVG/QrJkYs5R1PKgGYhlJVyOThQeQ1lj+VD1tg=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by LV3PR10MB7939.namprd10.prod.outlook.com (2603:10b6:408:219::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 13:00:35 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%3]) with mapi id 15.20.8746.031; Wed, 21 May 2025
 13:00:35 +0000
Message-ID: <c57d9070-37f0-4ba2-958b-be811a2d5778@oracle.com>
Date: Wed, 21 May 2025 09:00:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/29] vfio/container: pass MemoryRegion to DMA
 operations
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 John Johnson <john.g.johnson@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>
References: <20250520150419.2172078-1-john.levon@nutanix.com>
 <20250520150419.2172078-11-john.levon@nutanix.com>
 <6804143b-8dd4-4dba-84dc-c1ca44d3f4a6@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <6804143b-8dd4-4dba-84dc-c1ca44d3f4a6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0026.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::31) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|LV3PR10MB7939:EE_
X-MS-Office365-Filtering-Correlation-Id: 116a57e4-ac32-4213-79fe-08dd986779df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TnlSQ2hadjhIN2RRQVF0cFF6em9xcFVQTVNDWjdyS1BGUXVFbXhIUHEvMjRy?=
 =?utf-8?B?blBqZ1pwUjlwVlIyMDR0WlE4RklQb2Y4ekI2dm4wV1hGaHJwQTd0M1M2ejd1?=
 =?utf-8?B?YWNUZjY0elhzMFh2K3o2T0YwUWo1REgwTC91eWNQODIwQ2FiNE1GNXM3Z1dm?=
 =?utf-8?B?alVMYmROaDZvcHVhTGtvUEJDN3JpVTMxeHdHOEFJeElia1ltRUJucG00eVhZ?=
 =?utf-8?B?WGxJNzViVXdoQUFodkZPT090S01wQ0N3bFhLS2p1MzYwVEJ0MVYyOTRmZFBh?=
 =?utf-8?B?aG5wNEUvZEh5cXQwZnFESjhUVkdIQkNSenBwUk5kNDAzcFU0am5ueTA5bDJJ?=
 =?utf-8?B?SVIzeTQ3bjBNakZiTVBiajNua0YwWDlRT3RYQkNUMzdFRlBoRFBlODI3SHRt?=
 =?utf-8?B?YUlsMUd0UElmbFZYZG1xcG4rdDB4WHVKckpFeEFvZTRlZG90RFl0WTZ5UDlN?=
 =?utf-8?B?WmhBYlAvL0RrOFRabDU0OWE4c05BbTFMdXVMa2IvdG9TWVVFR3dBZVdsTTRK?=
 =?utf-8?B?UlBFWEpqa3hEK2c1dXJMQjN3dHB5VzI4OUx5NWc2V3NQRTlicDV4c2xBdjk1?=
 =?utf-8?B?UGZKbFpNMUZlVGFPNEw3WUNSRVpVVGlUTlc5eTlHbzIyN2dvSzlDRTdBTkVC?=
 =?utf-8?B?cU9nQ2ZaVGt5MWFZeWN2QW5pNnlnNUdIQjBUTTlFMDhCMVdOVXpkZ2VIcEwv?=
 =?utf-8?B?azNMVjdFTm85UXZkVU8yRUwxbFpkZncreXpIWTRWWGo1NDhuSHpPMTVtcGJv?=
 =?utf-8?B?VWp5ZysxYldpaXhjYnl2UGk2K09LV1JEOEtvazdtQWg3QVMwRGxZMEJRVi94?=
 =?utf-8?B?M1NwSmtSWXcxbmpjSFlqbUxiMHpZZk5CV2N6RVFkbHJWSGFHWmd1SnRocUZ0?=
 =?utf-8?B?ckxVQzVOM2c3ZndacXhDUDJqc3N2V0VoVGgvdGp0dUtHYmZaOFZxMUJudHg3?=
 =?utf-8?B?Mm1jbGZDWGFRbVJKdFVxaXNZVjlZSmhhY3JGNGVKeWNqQUhhaFBpU2tuU21C?=
 =?utf-8?B?SjFiSEo5WDk2MFFrMlFkc1N0VXpwWnY1em9iWWFNdlhTZEJod09lVVhZWXBN?=
 =?utf-8?B?K2ptRFhldkdMQTU1QTR1bHQ3aTUzdGhiNjlab21oTHVNNDRKMm43b3NMYkZ3?=
 =?utf-8?B?MzQrZmNjTVhxQUxZKzBybTlRQ3NqMXFaNHlHOTlRTTd2MjlzOEpIa3VIY2tz?=
 =?utf-8?B?ZHpRQUJHMDYzMUt0K01MY2FUTUFEclFGVHVwODdsWlBJOGthWEE4RG5RWTEw?=
 =?utf-8?B?RWh4Z29Mb3NCbzFzeFBwMU1kNm92Ty9jZGlrYjAyeFpSSTVZRG1CZGdjNzJr?=
 =?utf-8?B?UFdqM1ZNdC9McmhPUlFvaVFOYytvV1lpd1orbWxteng3V3huVDlyRzhqM1Bq?=
 =?utf-8?B?UFFGM1h1QzlQSmU4RFhDZ0U3dHZjQm5HdzhZdjZOUXJDS0VTUTA1QWVwTHZv?=
 =?utf-8?B?MUpnd3pMUFUvaUtFVXBrZkVHUVV0NFZteWhxTldycXFLQkxsOWNlbnZLN1hC?=
 =?utf-8?B?KzNlcHNuMkxaN1MwNFR0TXkrMVV0ZDhDb3J5bC9BdWIwZ0wyWU81MWtkUHl4?=
 =?utf-8?B?WlFDZDZUTTNZODN1Qkd4WmRzZXRPR3BxRWVlSkVMTHdzVXdSRXl6QllET1lm?=
 =?utf-8?B?SU5MQXN5ODhZRGhBa204NjlaMmgvUDh1ZGkzOEJpSmdZc1RETm43ZkNkSkdq?=
 =?utf-8?B?YjZMQWhWZ2prRTVyeWhZQWxGQm1nMHltbnplVU1jY3Rld0M4dzdmQzhRcENI?=
 =?utf-8?B?RDBLK0RmQ3ZCakc3M1kxYzArOWI4L211WFlNQkhEKzB0ZlhWZldVdzJJakF1?=
 =?utf-8?B?NVFvMTJCNHo0Nk85bkhMbWRkTVQ5NHpiblhwYUtEU3NqVjR0U29CbENnTFpr?=
 =?utf-8?B?OVM0MFBTbnN6TGVoWWJvWXUwV1NMc1FxSWlvZytmL2ErV0NmWW9QekpMQUJJ?=
 =?utf-8?Q?hg4BfTUn5f0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUhxbU5NVzdxaUE4bklPeXUxc1ZibFp6M09TQmVNUUV2ek50bGpZSkdpaklR?=
 =?utf-8?B?UG1LcHFlVXZQSkdsNFVTNG8rSzR3eTBra2pIcUtmYy83UnROc1htS2VaTXp4?=
 =?utf-8?B?QU9yR2hhcUNQODMveWRXcGtScnFqZTZjU1E1K3RYOW5yQmI1WWxyTlk1dFNP?=
 =?utf-8?B?QVBMU2puSk1hSHZBa2haVXVuL1ByNEJLUXlpSlJKeDAwaHBVNkJuVVNkMnJR?=
 =?utf-8?B?S0ZxOHVlT05xYTlEU2pxQjJYMG5seDV5aU1NWFllTmpteTZpTDZYWjIwRUJh?=
 =?utf-8?B?eEYxY2FreTlPcnAyRjZVNUtSQVN1M1Bqem1iY3dPZGxINTN4dVhDWXU2ZXcy?=
 =?utf-8?B?clpScnBVeEF6N1haU0lGMm5SWGhOdWRZMzNMMkxtcmpCak1WQWtrOENIQ21M?=
 =?utf-8?B?cllsZEFtZmExbkRNcUhlRkJnaFpPdHNpTUZFVTVkejJFbzFBOENRMW4wY2F4?=
 =?utf-8?B?Y0J0Z3BNOW9BQjRmbzYrdk9pd3h3WDNaSDRCaVMrRjV3RWM0Qjc5a2JrdVJ5?=
 =?utf-8?B?TktKdWNiNW9HWkFXVEZ0WFhJc296bUdiNVE1WUcyTjVNNnQzZzB5dVlraUtJ?=
 =?utf-8?B?YytpUzJjbE9wNXRYRnFVRmNURkFBOStMblVKL3RFTUlBZlI2Ump0UC8xQisy?=
 =?utf-8?B?OFloR2NXY3ZjblY2anRhSmcxQ2xWV1gzU3JDMFZ2b3ZNUmdhYm41OTdSU0NG?=
 =?utf-8?B?cjRIYVkveS9wVkc1THpsUEd5bnl1QldUY0kvam1FWGtRMjd2M2syR0hEc0pX?=
 =?utf-8?B?YWhKdzJPZHlqdlkvOHAwY3lBU0picThjc21FQ0NOVVFVeXhpdTFkcTRtWndC?=
 =?utf-8?B?c1BkSGVTa2Y4QllqVlhDZGxZQTJuSE83Y3o5TUNEbkl0MWErRE0wV284bVJY?=
 =?utf-8?B?LzRVREdybW13V01EY1NjS25vZDBJY1A2VkVJOHlhMkMvWUZibVB1V1piSnk2?=
 =?utf-8?B?dmtPMFI5Y0hpUjRsbnRza3psa1ZaNjBUMmpyV1lTVW9BVHdsbVlIL2VHMFRs?=
 =?utf-8?B?YVNDdHJIbi9rUWltcWxncFN1cVRtQlJaY0NFZEUvYnR5MGFKQVVQUW5KNW0z?=
 =?utf-8?B?OU85VEtwV1VyY241d3kzS0FKd2ZFa2FlNlo5cCt3SnJwYW0xbEFrWmRHeUk5?=
 =?utf-8?B?RWRLQVJ0Y2k2Ty9jTnR3dC9VeVhkc0J0V3Q5VmRuZjljUUQ3ckdCdjlKLzhh?=
 =?utf-8?B?ZHRyTDJ2dTE1VTB5Z1oraWRocnowdEc1Rjk5UGJrNVFsbUNmdUtnQ01ET1h4?=
 =?utf-8?B?UWh5R3F0RUZFY1ozL1BrNEtZd2NEY2pUTUlsZzZNODFORTNyc2I2emovOVNE?=
 =?utf-8?B?N0tvVWQ5Vjh5allReVVKeHNCV04vajVEbGc3Z0dQNnRHRUw0ais2MXpFaG45?=
 =?utf-8?B?cmdGMHRmZzZxMzVHQmpwUFI4ZzJVU1QyY2twaWlOYWpqL3lMYnV6N2VFbElU?=
 =?utf-8?B?VWdGQkhpZGFqRW9VWndDZHNBT2t2T3ZaR0ZqeDNQV1JRbmlvem9TZjlMbVRM?=
 =?utf-8?B?NjJFeU4rRGJGWi9ZWjVSazdoRWU3VmZTUEU3cXEvOHF5enlsbHVZY29IVW9u?=
 =?utf-8?B?eWczWnlEZXA3WkgwQU9xN0dETlFoN0l2OWI1SUxWeVo3ejV4VFpWUkgyNkVN?=
 =?utf-8?B?UzErZXJDM2dZRWRlb2NneWgrejM1TDdkVHdVOWZJaE81YVdWZWI2RTVIM1ph?=
 =?utf-8?B?ajdZOVcreXkrK0RHMEpnQndCYU9CQ1Qxc0ROc280QlVHYUVTb2dJdHFHejdQ?=
 =?utf-8?B?V1VidndLZnhqRXVWV0RQYUIvRGV5MncvdUJ5L1J5elNhc1lWTmZ1OUtxb0R6?=
 =?utf-8?B?UDAyVEhZK0t6aXN3RFlla3BXOGUvUlMxU0JQempvS1c0L2JzOWJBZ3N0ZVZ2?=
 =?utf-8?B?djFtUHNMNGo4dEZWUXlocTg0Qlh2Vm92dDBPM3NmdDU5ZzdyNlZEd0RtV0lw?=
 =?utf-8?B?WkZEYTRzOERBd1R2ZTM1bFpyb0lnTUxlb3lCMTdLdGx3Y3FNcUR4ZUsvMVdF?=
 =?utf-8?B?VjkvczlWVW9Gc29iSHE5bjVIdlRQY29vMG5wSVNuNElyL3R3OWVEdCtrVit3?=
 =?utf-8?B?K3hURjB6WUhSRlM5bEtjeXFwS0VoYXJDOHk3Qk45ZXRhNi9MalkzRTUyejBz?=
 =?utf-8?B?WUFyM2tQN2tLdUNXOSswSzdhbVdTYm5LK0Iwem5nd1FKT3FPM1JtWEEzaDdm?=
 =?utf-8?B?akE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ezgVMFpHbrlFQS7yqqv9TIxri37SG7gm4/Sb/gk8allS3QwJ2T0mM8U4NTZ7fj43vjjWWk8JRlkcYxbnsRyxu3Qo/DV3XjhO82btvev+J8FKAAjzZYv/MSg1T9CJwM507QML9WzRKTljzB5O9GKfKcGSlDpE7g6OUq7c4R9aEOpYsNAcCk7+0GaqgtY6V+17x2NMIdlqA0JxD82dBVzA70Worge7InRV8b26FTKXFB806MUdBbFiUVNRJdowcwL7BBMIju+qj9rEKUSkZV0K5OiKcig2u5n30pjU7btAwQ9w4jI86Tsn9TtwCi1St23hM0DVeEQLYLhJ88qtJG80pXG/h9//28KOUtzRoMKWU0IVcUQcQhSqTNWG10oZ1vCUGq61496334njZCPC6OpTsYCRFbz73iL34bNz5iK4gDhHsj7TuQW/Xl9YazgMz1lOJc/SB9/7PWC3LMTCAStW4EZyw3z97SIW9xRJYRoYIm7cInav5f9tOgkz4PBvQwk4tcsnzLew3xh6j2JVXLFA5rLYjUM8q0hpUGGUlTqJTWvl6PvVeR8TN0jKEL7cEUWWIkZzcfAoq1E6vmwoKmhdqk095CxmP1XOZrDeP6JBt24=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 116a57e4-ac32-4213-79fe-08dd986779df
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 13:00:35.2988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HcAfnykrnOluOIA23tU6lKBWuZQ+fgIzQjE+hKy+DUmz8yqUFapVLItpi97OKHHxpNMCzXpxu20t9AYh+RSIlwkBRUemeXunfQ1mcnsNgj0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7939
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_04,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505210126
X-Proofpoint-GUID: qzTlbWK1CArSZMgoVC5F4lRSZfMfmepA
X-Proofpoint-ORIG-GUID: qzTlbWK1CArSZMgoVC5F4lRSZfMfmepA
X-Authority-Analysis: v=2.4 cv=OZ2YDgTY c=1 sm=1 tr=0 ts=682dce7a b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=64Cc0HZtAAAA:8 a=CrTiVS9J9zCuY6qfnVYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14714
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDEyNSBTYWx0ZWRfX3M6aate89vZz
 wOz4Wyz3jLz0Dbl9dhz4mx1Ndgj4E0i9sOdnduqIOEKrhnbFdBZAq5wRNMXZMClYFONeu3q4gWX
 JLzXtbF0FLVUoJ50rIPD3xZJ6PxUzHHSUuRwwYZw79wdPQIRqYh59LxlP5RzfNQdSTTESMGDrNk
 fZgpRGeglRqQPfprmz+GC33yqoAM3lgzC54PHmGIlyA+7BFVpuyXm4Gl8ckzxdNKxx3CZQQcBiZ
 Ak61r46AQaHKvUYg06qgvRfwGTY8bXLTZXWFwgT10rpX/E2FiUW8E7Lb7JpvBnhz1cxeN0/kcXL
 kJRBOeybQwjiAdpp5RQBB0MblCUGbu0uT+68zFKzRamdozRZ2XNji4MLH6qKgS+QZH2DPLlAdKf
 XDaY5tXN4FSjs6m3ZX+l0r9ll70l64jhsEvSCRWxmYp2vocLe+afruoAUsU+w62H3hOLMK1T
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

On 5/21/2025 3:43 AM, Cédric Le Goater wrote:
> +Steven,
> 
> On 5/20/25 17:03, John Levon wrote:
>> Pass through the MemoryRegion to DMA operation handlers of vfio
>> containers. The vfio-user container will need this later, to translate
>> the vaddr into an offset for the dma map vfio-user message.
>>
>> Originally-by: John Johnson <john.g.johnson@oracle.com>
>> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
>> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
>> Signed-off-by: John Levon <john.levon@nutanix.com>
> 
> 
> This change conflicts with :
> 
>    https://lore.kernel.org/qemu-devel/1747063973-124548-28-git-send-email-steven.sistare@oracle.com
> 
> Steven,
> 
> Could we use this version instead for the "live update" series ?

Sure, I will drop my patch and use this.

A few nits, iff there is another version of the series.

I suggest "mrp" be renamed "mr", to be consistent with all other
MemoryRegion* variables. A MemoryRegion is never passed by value,
so the "p" is understood.

This comment for @dma_map needs polishing for clarity:

+     * Map an address range into the container. Note that @mrp will within an
+     * RCU read lock region across this call.

- Steve

>> ---
>>   include/hw/vfio/vfio-container-base.h | 9 +++++----
>>   hw/vfio/container-base.c              | 4 ++--
>>   hw/vfio/container.c                   | 3 ++-
>>   hw/vfio/iommufd.c                     | 3 ++-
>>   hw/vfio/listener.c                    | 6 +++---
>>   5 files changed, 14 insertions(+), 11 deletions(-)
>>
>> diff --git a/include/hw/vfio/vfio-container-base.h b/include/hw/vfio/vfio-container-base.h
>> index 41c49b2aa5..c18986a621 100644
>> --- a/include/hw/vfio/vfio-container-base.h
>> +++ b/include/hw/vfio/vfio-container-base.h
>> @@ -78,7 +78,7 @@ void vfio_address_space_insert(VFIOAddressSpace *space,
>>   int vfio_container_dma_map(VFIOContainerBase *bcontainer,
>>                              hwaddr iova, ram_addr_t size,
>> -                           void *vaddr, bool readonly);
>> +                           void *vaddr, bool readonly, MemoryRegion *mrp);
>>   int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
>>                                hwaddr iova, ram_addr_t size,
>>                                IOMMUTLBEntry *iotlb, bool unmap_all);
>> @@ -149,18 +149,19 @@ struct VFIOIOMMUClass {
>>       /**
>>        * @dma_map
>>        *
>> -     * Map an address range into the container.
>> +     * Map an address range into the container. Note that @mrp will within an
>> +     * RCU read lock region across this call.
>>        *
>>        * @bcontainer: #VFIOContainerBase to use
>>        * @iova: start address to map
>>        * @size: size of the range to map
>>        * @vaddr: process virtual address of mapping
>>        * @readonly: true if mapping should be readonly
>> +     * @mrp: the memory region for this mapping
>>        */
>>       int (*dma_map)(const VFIOContainerBase *bcontainer,
>>                      hwaddr iova, ram_addr_t size,
>> -                   void *vaddr, bool readonly);
>> -
>> +                   void *vaddr, bool readonly, MemoryRegion *mrp);
>>       /**
>>        * @dma_unmap
>>        *
>> diff --git a/hw/vfio/container-base.c b/hw/vfio/container-base.c
>> index 1c6ca94b60..a677bb6694 100644
>> --- a/hw/vfio/container-base.c
>> +++ b/hw/vfio/container-base.c
>> @@ -75,12 +75,12 @@ void vfio_address_space_insert(VFIOAddressSpace *space,
>>   int vfio_container_dma_map(VFIOContainerBase *bcontainer,
>>                              hwaddr iova, ram_addr_t size,
>> -                           void *vaddr, bool readonly)
>> +                           void *vaddr, bool readonly, MemoryRegion *mrp)
>>   {
>>       VFIOIOMMUClass *vioc = VFIO_IOMMU_GET_CLASS(bcontainer);
>>       g_assert(vioc->dma_map);
>> -    return vioc->dma_map(bcontainer, iova, size, vaddr, readonly);
>> +    return vioc->dma_map(bcontainer, iova, size, vaddr, readonly, mrp);
>>   }
>>   int vfio_container_dma_unmap(VFIOContainerBase *bcontainer,
>> diff --git a/hw/vfio/container.c b/hw/vfio/container.c
>> index a9f0dbaec4..98d6b9f90c 100644
>> --- a/hw/vfio/container.c
>> +++ b/hw/vfio/container.c
>> @@ -207,7 +207,8 @@ static int vfio_legacy_dma_unmap(const VFIOContainerBase *bcontainer,
>>   }
>>   static int vfio_legacy_dma_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>> -                               ram_addr_t size, void *vaddr, bool readonly)
>> +                               ram_addr_t size, void *vaddr, bool readonly,
>> +                               MemoryRegion *mrp)
>>   {
>>       const VFIOContainer *container = container_of(bcontainer, VFIOContainer,
>>                                                     bcontainer);
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index af1c7ab10a..a2518c4a5d 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -34,7 +34,8 @@
>>               TYPE_HOST_IOMMU_DEVICE_IOMMUFD "-vfio"
>>   static int iommufd_cdev_map(const VFIOContainerBase *bcontainer, hwaddr iova,
>> -                            ram_addr_t size, void *vaddr, bool readonly)
>> +                            ram_addr_t size, void *vaddr, bool readonly,
>> +                            MemoryRegion *mrp)
>>   {
>>       const VFIOIOMMUFDContainer *container =
>>           container_of(bcontainer, VFIOIOMMUFDContainer, bcontainer);
>> diff --git a/hw/vfio/listener.c b/hw/vfio/listener.c
>> index 0afafe3464..a1d2d2561d 100644
>> --- a/hw/vfio/listener.c
>> +++ b/hw/vfio/listener.c
>> @@ -170,7 +170,7 @@ static void vfio_iommu_map_notify(IOMMUNotifier *n, IOMMUTLBEntry *iotlb)
>>            */
>>           ret = vfio_container_dma_map(bcontainer, iova,
>>                                        iotlb->addr_mask + 1, vaddr,
>> -                                     read_only);
>> +                                     read_only, mr);
>>           if (ret) {
>>               error_report("vfio_container_dma_map(%p, 0x%"HWADDR_PRIx", "
>>                            "0x%"HWADDR_PRIx", %p) = %d (%s)",
>> @@ -240,7 +240,7 @@ static int vfio_ram_discard_notify_populate(RamDiscardListener *rdl,
>>           vaddr = memory_region_get_ram_ptr(section->mr) + start;
>>           ret = vfio_container_dma_map(bcontainer, iova, next - start,
>> -                                     vaddr, section->readonly);
>> +                                     vaddr, section->readonly, section->mr);
>>           if (ret) {
>>               /* Rollback */
>>               vfio_ram_discard_notify_discard(rdl, section);
>> @@ -564,7 +564,7 @@ static void vfio_listener_region_add(MemoryListener *listener,
>>       }
>>       ret = vfio_container_dma_map(bcontainer, iova, int128_get64(llsize),
>> -                                 vaddr, section->readonly);
>> +                                 vaddr, section->readonly, section->mr);
>>       if (ret) {
>>           error_setg(&err, "vfio_container_dma_map(%p, 0x%"HWADDR_PRIx", "
>>                      "0x%"HWADDR_PRIx", %p) = %d (%s)",
> 


