Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA414C3ABC9
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 18:19:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFzdr-0008EJ-91; Fri, 16 May 2025 14:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uFzdp-00088i-2H
 for qemu-devel@nongnu.org; Fri, 16 May 2025 14:18:41 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1uFzdm-00032H-At
 for qemu-devel@nongnu.org; Fri, 16 May 2025 14:18:40 -0400
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54GGfuXU001051;
 Fri, 16 May 2025 18:18:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=OinLfBfPoHjtv7DH9F8xUJZQYe2vgPE3xfNuYAGhtI8=; b=
 Jnza/90tUPcFnlmekQmP/RpU9VFbsAiakmOJYbHPq5u3E++Wl1eK5p4FkWDyacOs
 V2/yV7+7kUd6fopvLSsZ36Amyg2w77T16P0z3SiZ8gSU3VQl0LW9Zqwnkpcu7LTT
 PvJLoQri1FCAdg8uCBgy40dkdDgQrq+5XMSPCQbkhMB27lsJ0SsfvzU8vo/0XfFk
 r8HptfDhA29zD3jM6I72teip86KUY5Xs/NYKeKRARnNkHhNmzE3iArW/NYqTIT+2
 ZH5GQMGLUKq2yT5bWHwHkmNiohty0gEm9I9GC8FuSqN3h+cKvsGaFo3SQbzyw3eA
 KmN19LGv0wpVr2lkX9sTaQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46nre01xxp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 May 2025 18:18:34 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 54GGxH20016293; Fri, 16 May 2025 18:18:33 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com
 (mail-westcentralusazlp17011027.outbound.protection.outlook.com [40.93.6.27])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 46mc36cndw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 16 May 2025 18:18:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FdAlrJ36jJSkN8m3VBx7KMLLjv0l5PadZh5wuyKPT91YTfqET9AStt62D8bXrgx6ZV6c4MF1jTuEQTou+j43pvC1SMvn50yLbKuTPX5r9UhYfJ1MkvPSSqE3GNKXXMsBLsWfiASm54H4cIhuGvZRwVYKlNPOAVZYpkyChZv8L6Du5wXT+xJm7RENA57NVq81etkzRKYg/mMX242Te6OqIbpWW3C6p+zBJtQ5f6NZWkjl3ejUMSnHSWdHQ0DEx3XyE98ITmKCs43de5RsVF4VK3uORVxKlfGTMka7WhRLCcIIx+BL0oAZR5H2GIuQfx+cipJFk7W4YMAsS+a25LAXuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OinLfBfPoHjtv7DH9F8xUJZQYe2vgPE3xfNuYAGhtI8=;
 b=FLMba3I91iaUgiD+A125PP80I/wSYsbV48FD5oEyQkjU0XaHOo8Wwifnj3N1uOy5escmupIqNVrBKEYJXZg/EVMmC8NfqU4RAEwFwTOcSbXN3yYfhqb3ygs2GyM+COJ8FOOhPA0jEP+GkVMyeIvun5Zxs20oqpdj34RAgCd3mpeGC2juOIcDjcczn6DXyEsSDfHsK8v/UVcyoP2S/5EdmXXyg2RylvnqeFyZEAxkyRvFIcTPSFwNQZs/lKINLDCkGZZfUCj7eddmwXoLGzIViatkkTj49YU+vEany2/vYrTIz5Srh8xTmoKO1K/9kNiim7JfwuzrpbWKjuIrQ+54Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OinLfBfPoHjtv7DH9F8xUJZQYe2vgPE3xfNuYAGhtI8=;
 b=qtomsQACZIt+XnUHuJSbmU3n+mxQbt+8RYz7+XHeoFkX701OU3tzIlCgthRevVgRVKbLGZBnFmEMZikPHp+ENtAmawk97fQ3J/Jz30fvD33xfUVqHVYTnYn5n+reK/uXWqzWx4+55acr+1UaWKYQmlyInILK3JiILCJ7UeDIhTI=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by SJ2PR10MB7015.namprd10.prod.outlook.com (2603:10b6:a03:4c1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Fri, 16 May
 2025 18:18:30 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%6]) with mapi id 15.20.8722.027; Fri, 16 May 2025
 18:18:30 +0000
Message-ID: <fb047fe4-1a8d-42c5-98c2-28adfee0f23a@oracle.com>
Date: Fri, 16 May 2025 14:18:28 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 24/42] migration: close kvm after cpr
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
References: <1747063973-124548-1-git-send-email-steven.sistare@oracle.com>
 <1747063973-124548-25-git-send-email-steven.sistare@oracle.com>
 <9a664228-9a00-4387-b2d0-f7a428b52c75@redhat.com>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <9a664228-9a00-4387-b2d0-f7a428b52c75@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0764.namprd03.prod.outlook.com
 (2603:10b6:408:13a::19) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|SJ2PR10MB7015:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d2352b5-80f9-4b4a-19db-08dd94a60f56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UDdkeDVTRElHQzNCOUxJdVYxS0MxN1B3b0pUZFBoNUlCY25BemtrMGlHaDI3?=
 =?utf-8?B?bUZ3eWRuOXliOE13L09UU0UwTmRwdjdiSzJiRXNoWSt2djI1aWdKN0thZ2xV?=
 =?utf-8?B?MXh2cXNwczJLSGt3YXNhTm5IdkV4Nk42dmlXOTViWXVIQm9GNjZxTUU1Wlpr?=
 =?utf-8?B?SlcxZW1KckwyVEk1WWFEa3ByYlVScFNlNlVMMjhyQ0pVZUpIbURVTVN3TDU3?=
 =?utf-8?B?aEN5ZXUxc3dRdE9VTysvQnBJc1NzcVNpVkhnV3NvY3JrME1NeEptQkJJSnky?=
 =?utf-8?B?TWlJdjlaT25UUDRqQU5ONTk3TzJxOWJyT05qWTZqUkhqdWcrOWZ3OE54elQ3?=
 =?utf-8?B?VUk5ODM5TFFYNnRjbUlsOXlCQXpDSGFPZjdUekpRSGp0UERjQVoveVBFYk5o?=
 =?utf-8?B?blV2WVhCNmpyVjFtcmE5U2ZNalpodzR0RXRGMWl6QkJETTRzQTVHdzJkSHNk?=
 =?utf-8?B?RFplekJjUUEwWE95RXlJOWxUNXNpZ3JlTytyTHlKUDNwMVlwRkplbExpN2Vs?=
 =?utf-8?B?V2NpZXY1Q3JUcjhMUlVFOVdOQzEwZHkxZjQ1N2FScUtFWVNsYVU5U1FFTCtr?=
 =?utf-8?B?c1A2ZmJMTnhTYlJhU3JKaU5mTXdNZ091ZFdTK3RFNFJYRmVIdWczRFAxSE9U?=
 =?utf-8?B?U3JuYzZNRzJpQ1JYZ1pUTHovOE8wS1hDZXJjRUtQM0hVQXlIcGhMTjBqT1VE?=
 =?utf-8?B?T0tLZnJwbWQ5YTRWbTN1bUx2N1c1S0VPZlcrWjBicVRINVNiMEhuSkpEUHdD?=
 =?utf-8?B?QWtpSDdqbWJxTElON1EvK0NMbjJWaW1OZ1l2MXlpMG1lUklvbWxKQlJvQzI3?=
 =?utf-8?B?cVFXbUhyYmJwc3FrMVJtVXhnbGc2SHlSZmFCMHphNE00V0hmcW1TanVYL2dL?=
 =?utf-8?B?NnRYSk5YcW1EN0lBejdFL0V2VnlheTBLUmQ2V000ajBMUmF0UzdWS2dxTFpJ?=
 =?utf-8?B?N2lCOXhya0kzSnBBNStURTBSeUgxTmphc2Yvb25MR0tTbG90elQzSVdWeEhE?=
 =?utf-8?B?WEV3Q2NXenJoRko4YXhHTXl0YTVta0JpYklETjVzNk55T2syc056TU1kQVli?=
 =?utf-8?B?NmMrU2h2cjI2T0taQm5LTGRlcE1HUFlvSktQMkF5eTcvQjBzNi9xb21YNmow?=
 =?utf-8?B?alhYWU5SQnhXZ0RvbXVBL3VVeGRuYkJvWkZrcS9zemR3am1sVnFENWJUcDVp?=
 =?utf-8?B?YTkwWm1GMnl2TzFRc0YzZVI4SFpGZTQycDQ5YXc0MXRyY2twWEtmeTVVNWJ6?=
 =?utf-8?B?NTV2dmV1RGJXb3lQS3dhY05IaU0vZ2VVbXhXTmRCSVlVWU5qRjBOQ2t0aVRT?=
 =?utf-8?B?aGlnUVF4RG1Xb2JZSU45QzRITDUvL2hpQ1dYaWtLaFVZR0ZlVVJseUhCRC9w?=
 =?utf-8?B?Qm5SWWVWZUx6UlA3YzBxR1NZMVJhZy96VmJzbjhCM1FFb29la2w0ZXoveXRm?=
 =?utf-8?B?VC9odU04aDFGQWxUdWJnWDhLcmhWZ1VqcVlwalBwT0VlbU1mOStOeS9yd2FE?=
 =?utf-8?B?S09qOTNpMHprTnYxcUw0MWhkTVRlUzh6N0NCRmllbVFJblZVVnZCRTNkTzdC?=
 =?utf-8?B?NDlWZmdJUFBMcWhZK2FROUszcm02eVQyMnlIdHFsOVJCTXozS0NTaWg4dWhM?=
 =?utf-8?B?MHkvN3RVb2JVcmovWE94ZGRhRUd3UmFYb0VFcFkzN1pOK2RxcDduYnhvRzJm?=
 =?utf-8?B?QStiNS9ZTEZLeVNqNjRIaXNyZUJLYXpSc3B1b1lrZ1kzNVdjdlJlalQwZnE4?=
 =?utf-8?B?a3U0VzMwd3V5dzU4LzZFNEh5RkdnOWVSWHZDRGlYK280TmlxY1htNXg0SE5M?=
 =?utf-8?B?N0RzOXh2blY0TksxVVhySUJSVDRzNHNaMWlIQ1RiYkVnYm94MGJiVTVGREs2?=
 =?utf-8?B?YjQ5dFZjVnZ2akIyc0tLMTBPWU9UYjJDTkZFU0FzL0tZcmdvTnVKb2UzK3d4?=
 =?utf-8?Q?0wtQIxw4GaY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnozUmNUUzh1QldaWXRHNWdxY2hqSE1RZzBTUFk0TGRRcXJJM1JpY2pTVW1T?=
 =?utf-8?B?NjlBWVpFNktOSDhxUlArWkoxRGRMdGpyUVFCY2dyWWdpdDk4UVlsYnM0WGln?=
 =?utf-8?B?OHlidVZOY0tYY2JOdVUyM2pGVkRhVWxSSTlBdCtsT0x3WGtmQnA3Y1lORzhx?=
 =?utf-8?B?TGFRcmFVQXRMdFhTZitDTjNONm9rYkJJMi80OFNya3dDZ2ZNODBhNjVCUUZp?=
 =?utf-8?B?bmlkRDNaTlF4T01OK3lkcE5veWFoK1dJYUU3Q3VsUHYzZmtTQm1ZQ3N4aVZs?=
 =?utf-8?B?OGhobEVRL2ZlWjBnclRUSURCeC8vN2xrTUw4UkNOeXEranc0eWt2R0J6U2l0?=
 =?utf-8?B?aTV6TkdZU2NjbkRSVEgyUjE4WmZXbG9JWWFNblV4L1FwWmQxRjVjTUkydFhN?=
 =?utf-8?B?bkp0YWxDTit6SDljTFZ4cE1JZDRNSU1pOFdnQ1NXUFhZTkQ1cmpjcXp2dHlx?=
 =?utf-8?B?SFdxTW5hYk9vdStGNUdRNHhFcmxVNXM0TGY4L2RQRjg4QklEUGpHbGpFa3FH?=
 =?utf-8?B?TWk0MVAwZ2c0VXdsU0dKZzZQRm5NNW5iVlpwTk5BYXBESGZUSVdPb1NsUVZp?=
 =?utf-8?B?TjAybjZSNlc3YmEvTExlMUJtWlpEZUVLMW55Z3VOZ0JQa1B4amtLeWMwdHo1?=
 =?utf-8?B?K2JBZ2tEL3paMnZlMDlEc0ZrQWxCVkZ4ZlhSelJtYlN0Y0txVGp2U05naEw2?=
 =?utf-8?B?NGEwZGgweXBSd2g0ZExYdWVWUGtlVnU0YzNXOE9EZnNIZEZnNUZNWU0rRThT?=
 =?utf-8?B?M0xJRDNiNTZkWFVuZWVmWVF2czRQOEwrWHJwNlBPbXplQWdRU3hZaENYZytS?=
 =?utf-8?B?c29NNXpCUTMxRy9xSlN2cFhIcnFWSTR5MmI0YVpHVHFiUk9rTjZ3TlJHZm14?=
 =?utf-8?B?T2p2YWhlY1pxcXdsZ0pkWGY4blV1WUU2OCtGUkk2UHdLVVNaWjBrZlV6Vmwr?=
 =?utf-8?B?dWVBZ21sZkZId0sxVnBkb1BOZ3Rtd2xUSkZaQzdJcUdYVUpiVTBDVURVS2xy?=
 =?utf-8?B?UlZuZjhQY09XZGxxeW00OHB6amNMeUlGS3pCTXBMelEzQkxpc0hjVi90Vi9V?=
 =?utf-8?B?bktGc1hkNzk2a2tnK2tXcnkrd0lvV3VZbWtSVmx2K2pmeERwMkJnS1Bsbys5?=
 =?utf-8?B?ZytmM2l0VjZGK3JIbVBubU9XcXRIdmJqU0ZFVkU1YnZyQXNicEhCb0xodVVD?=
 =?utf-8?B?SW9vNjc3WUR4eW8wRWtnbDBiTStnWEFtRVF1TFU0K3RMMldyUFBsWEhQSnpW?=
 =?utf-8?B?QmI5ZnAyMmJPOFM0K3FzTUx5TjZSUVNmczU5R052b2xSWnZmUVBCYStYTm1D?=
 =?utf-8?B?cGZ4RGxRRGlRdmx2dmRLUjJsOGsweEZLcFZjellFNmIzN3ZlaE5tOEg2eWIr?=
 =?utf-8?B?WjVZVUppcUw2QjJGOCsrYXpQUDNNdjd4VEsrSU1uNkM3L3VXL2pyalVVTlc1?=
 =?utf-8?B?UG54MVVMdHNicldYOHVUczZjRWJDYlRHVFNsRjdEcjRDOGlyNUxqU0x3M1JS?=
 =?utf-8?B?T1g1aW9Sa3BoM28xcGVnaytjRFF6VDg5dlZ4b3BLUHdQVjNuU012RXdWREI0?=
 =?utf-8?B?ZzRZTXhrd0d3a1BGNHBZcXZBcEFHbUp1VFpLeFp4NEs5WWZ0QXIvMmwwejRt?=
 =?utf-8?B?WTVMOVZFVDZEOTFleGxpWW9POGZCNXRMcWRlNXZ2RnNkS0diRndOdmVLNVNU?=
 =?utf-8?B?c3NqTXNnRWoySGxLSWtBWjJVdlhsNGRUSXREY3RjZ203ckRBalVpYmhJM0Mv?=
 =?utf-8?B?MFBQVmkxbE0rRDd6R0ZNSGl1aXJXbFg3MGdOVllibm9IZXR6TDdsUml5bVhX?=
 =?utf-8?B?dnREZGdpUWtQRzdlbm90bGJ2aVZLK3hHSEdoM2VxQ3hqWXlGRWtzQnhlSHRI?=
 =?utf-8?B?RFAwRUVGN0dUYU1zSFF1Rk5jdW1icUoxZ3NPUFFOc3FWTE9HSnN6NEpvSkV2?=
 =?utf-8?B?dFloNWpNZ2FveGYxdkRUYmpJVFpKRmJzVUxGZkgxS1NkWFpJdjJjT0RRWWFa?=
 =?utf-8?B?NjBOSUp6ck1YUUhaK09sYjR0Z0ViaUdFSnU4dUIrNk9wQlBCQjY4UEhIbnk3?=
 =?utf-8?B?VWVsTGdDaThuaTAxYkpkdFpIVnBJREpHN3BJc21FTHQ3dU5CN2NOWjFBQTlR?=
 =?utf-8?B?RGFDYy9XWVdDZEYyT1FjT3U0VlBLZ3NEUmNYYWhSaWxSV3dvVTRTMk0wL3VV?=
 =?utf-8?B?Snc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ARGWmT4lHtyqI6hEWTe01p6j6O6AxtyLLK+CtFPyfQ+wMxJ7TdFPYp9GJZdCWEqAF3EGJEM0/MGpIv3vSQxNDFcFF5zagYB+wO7zvSBmcJJNeSYWnZFjIhwygzKcLnK0yfuX1vvn6MHZtYx3dzcsPcPiF369rxP3WsDj2iRPy0M/Zv/0TEldH99hZw5FsqsCtXh7GA9cloyFx2fRObZE7/4ydiU/lPLtSUkVNbUsUYZFVoM/osQ65kqsVwUGiNN/r47YMIB+C+6B0oWewVQK997ZAxVfOul/6xW5I5KAJHDl/5IH6ssPYuWKBLczYc1UwdNB3bj+rjdUBI60Dh87msOV+v5rMsKit87wTgdRkRj++eIj9mVAoU6dQsYKcJ0oNjarUhXoSoIZ/xB53QAlbM4BRiJDBgr9w0Tdcj6YKmRYybLut3K2aMSNZNW0+8BNqWaUPjcv10wwaxfgp9EaRd3ZbGRUOarZFYxlg8Uh+rSq/3sNZRXbNO1N7VQ3p2mhLXS9t8//He8dK2aq5WN5LZLoMXI+ZNhg81UN4eu3WYdtpzZkA6GSry623Ptj7sRVODwCYGPD/rTSwT1+6Q2Uw5oF1ZQEacf74tFa/2TQ75g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d2352b5-80f9-4b4a-19db-08dd94a60f56
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2025 18:18:30.1613 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 24/solxmU3Vu0tjwNjiL7wXSty4gZk3aG76Xv/vwoPC/Ad+qUtHYweFc1+oUAMYuNQHnBIbGnbP/0wSBlv5RVYlNgASIGLFf1GU/Y5teZUA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7015
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-16_06,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 suspectscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505070000
 definitions=main-2505160179
X-Proofpoint-GUID: b7zUX1vjDGloQwiPG9xO1Qrs9NfZgmZv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE2MDE3OSBTYWx0ZWRfXwSRKJyYlJT94
 NFHPHS+Rgw7UVC/sY1p8LNwpKvlvWTvO1Bse5oVl1XAzjmQZpB85Kf7Tk35qWQp6edqUXLdgo+m
 XtIgrj5LgRy5EL4naDIQs68Zw7WmPQvoahOOySMvMioUjizMsWaYr2yNPn76HmBEf2OCIkeM3K4
 A1qrWq3nuGEzfZ4+li+7WYxF4ty2Ygo1X7+nQ8F6e8MV0RAlWi31LdCOrUlZG2qJLWkSGRwGB8D
 Pony0+DRePm0/mj8h5PN4HPJEgyb0LQ9JFVcvhyUihr81w9XzW0fzuGnou4exvJERcD7YMwEfc/
 dlnVbg/P5nJfMovu9UTKcsdFjullsBCeJ+xV1eE1YLcTXR2jpB0/qkYUhX8MZj0F0BR+zrnr1pZ
 P7Pyoeu3F+NBMSn9YZm0wBpyPIofedhTWPxQKZfQp036QTW53JgIhRWweC3TYyAH4Al2UQgG
X-Proofpoint-ORIG-GUID: b7zUX1vjDGloQwiPG9xO1Qrs9NfZgmZv
X-Authority-Analysis: v=2.4 cv=O9s5vA9W c=1 sm=1 tr=0 ts=6827817a b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10
 a=yPCof4ZbAAAA:8 a=ckCqCLwD2UvsXLL-MMcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:13186
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

On 5/16/2025 4:35 AM, Cédric Le Goater wrote:
> On 5/12/25 17:32, Steve Sistare wrote:
>> cpr-transfer breaks vfio network connectivity to and from the guest, and
>> the host system log shows:
>>    irq bypass consumer (token 00000000a03c32e5) registration fails: -16
>> which is EBUSY.  This occurs because KVM descriptors are still open in
>> the old QEMU process.  Close them.
>>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> 
> This patch doesn't build.
> 
> /usr/bin/ld: libcommon.a.p/migration_cpr.c.o: in function `cpr_kvm_close':
> ./build/../migration/cpr.c:260: undefined reference to `kvm_close'

My build works.
For what binary does this ld command fail?
Could you send the complete ld command with make V=1?

- Steve

>> ---
>>   accel/kvm/kvm-all.c           | 28 ++++++++++++++++++++++++++++
>>   hw/vfio/helpers.c             | 10 ++++++++++
>>   include/hw/vfio/vfio-device.h |  2 ++
>>   include/migration/cpr.h       |  2 ++
>>   include/qemu/vfio-helpers.h   |  1 -
>>   include/system/kvm.h          |  1 +
>>   migration/cpr-transfer.c      | 18 ++++++++++++++++++
>>   migration/cpr.c               |  8 ++++++++
>>   migration/migration.c         |  1 +
>>   9 files changed, 70 insertions(+), 1 deletion(-)
>>
>> diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
>> index 278a506..d619448 100644
>> --- a/accel/kvm/kvm-all.c
>> +++ b/accel/kvm/kvm-all.c
>> @@ -512,16 +512,23 @@ static int do_kvm_destroy_vcpu(CPUState *cpu)
>>           goto err;
>>       }
>> +    /* If I am the CPU that created coalesced_mmio_ring, then discard it */
>> +    if (s->coalesced_mmio_ring == (void *)cpu->kvm_run + PAGE_SIZE) {
>> +        s->coalesced_mmio_ring = NULL;
>> +    }
>> +
>>       ret = munmap(cpu->kvm_run, mmap_size);
>>       if (ret < 0) {
>>           goto err;
>>       }
>> +    cpu->kvm_run = NULL;
>>       if (cpu->kvm_dirty_gfns) {
>>           ret = munmap(cpu->kvm_dirty_gfns, s->kvm_dirty_ring_bytes);
>>           if (ret < 0) {
>>               goto err;
>>           }
>> +        cpu->kvm_dirty_gfns = NULL;
>>       }
>>       kvm_park_vcpu(cpu);
>> @@ -600,6 +607,27 @@ err:
>>       return ret;
>>   }
>> +void kvm_close(void)
>> +{
>> +    CPUState *cpu;
>> +
>> +    CPU_FOREACH(cpu) {
>> +        cpu_remove_sync(cpu);
>> +        close(cpu->kvm_fd);
>> +        cpu->kvm_fd = -1;
>> +        close(cpu->kvm_vcpu_stats_fd);
>> +        cpu->kvm_vcpu_stats_fd = -1;
>> +    }
>> +
>> +    if (kvm_state && kvm_state->fd != -1) {
>> +        close(kvm_state->vmfd);
>> +        kvm_state->vmfd = -1;
>> +        close(kvm_state->fd);
>> +        kvm_state->fd = -1;
>> +    }
>> +    kvm_state = NULL;
>> +}
>> +
>>   /*
>>    * dirty pages logging control
>>    */
>> diff --git a/hw/vfio/helpers.c b/hw/vfio/helpers.c
>> index d0dbab1..af1db2f 100644
>> --- a/hw/vfio/helpers.c
>> +++ b/hw/vfio/helpers.c
>> @@ -117,6 +117,16 @@ bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
>>   int vfio_kvm_device_fd = -1;
>>   #endif
>> +void vfio_kvm_device_close(void)
>> +{
>> +#ifdef CONFIG_KVM
>> +    if (vfio_kvm_device_fd != -1) {
>> +        close(vfio_kvm_device_fd);
>> +        vfio_kvm_device_fd = -1;
>> +    }
>> +#endif
>> +}
>> +
>>   int vfio_kvm_device_add_fd(int fd, Error **errp)
>>   {
>>   #ifdef CONFIG_KVM
>> diff --git a/include/hw/vfio/vfio-device.h b/include/hw/vfio/vfio-device.h
>> index 4e4d0b6..6eb6f21 100644
>> --- a/include/hw/vfio/vfio-device.h
>> +++ b/include/hw/vfio/vfio-device.h
>> @@ -231,4 +231,6 @@ void vfio_device_set_fd(VFIODevice *vbasedev, const char *str, Error **errp);
>>   void vfio_device_init(VFIODevice *vbasedev, int type, VFIODeviceOps *ops,
>>                         DeviceState *dev, bool ram_discard);
>>   int vfio_device_get_aw_bits(VFIODevice *vdev);
>> +
>> +void vfio_kvm_device_close(void);
>>   #endif /* HW_VFIO_VFIO_COMMON_H */
>> diff --git a/include/migration/cpr.h b/include/migration/cpr.h
>> index fc6aa33..5f1ff10 100644
>> --- a/include/migration/cpr.h
>> +++ b/include/migration/cpr.h
>> @@ -31,7 +31,9 @@ void cpr_state_close(void);
>>   struct QIOChannel *cpr_state_ioc(void);
>>   bool cpr_needed_for_reuse(void *opaque);
>> +void cpr_kvm_close(void);
>> +void cpr_transfer_init(void);
>>   QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp);
>>   QEMUFile *cpr_transfer_input(MigrationChannel *channel, Error **errp);
>> diff --git a/include/qemu/vfio-helpers.h b/include/qemu/vfio-helpers.h
>> index bde9495..a029036 100644
>> --- a/include/qemu/vfio-helpers.h
>> +++ b/include/qemu/vfio-helpers.h
>> @@ -28,5 +28,4 @@ void qemu_vfio_pci_unmap_bar(QEMUVFIOState *s, int index, void *bar,
>>                                uint64_t offset, uint64_t size);
>>   int qemu_vfio_pci_init_irq(QEMUVFIOState *s, EventNotifier *e,
>>                              int irq_type, Error **errp);
>> -
>>   #endif
>> diff --git a/include/system/kvm.h b/include/system/kvm.h
>> index b690dda..cfaa94c 100644
>> --- a/include/system/kvm.h
>> +++ b/include/system/kvm.h
>> @@ -194,6 +194,7 @@ bool kvm_has_sync_mmu(void);
>>   int kvm_has_vcpu_events(void);
>>   int kvm_max_nested_state_length(void);
>>   int kvm_has_gsi_routing(void);
>> +void kvm_close(void);
>>   /**
>>    * kvm_arm_supports_user_irq
>> diff --git a/migration/cpr-transfer.c b/migration/cpr-transfer.c
>> index e1f1403..396558f 100644
>> --- a/migration/cpr-transfer.c
>> +++ b/migration/cpr-transfer.c
>> @@ -17,6 +17,24 @@
>>   #include "migration/vmstate.h"
>>   #include "trace.h"
>> +static int cpr_transfer_notifier(NotifierWithReturn *notifier,
>> +                                 MigrationEvent *e,
>> +                                 Error **errp)
>> +{
>> +    if (e->type == MIG_EVENT_PRECOPY_DONE) {
>> +        cpr_kvm_close();
>> +    }
>> +    return 0;
>> +}
>> +
>> +void cpr_transfer_init(void)
>> +{
>> +    static NotifierWithReturn notifier;
>> +
>> +    migration_add_notifier_mode(&notifier, cpr_transfer_notifier,
>> +                                MIG_MODE_CPR_TRANSFER);
>> +}
>> +
>>   QEMUFile *cpr_transfer_output(MigrationChannel *channel, Error **errp)
>>   {
>>       MigrationAddress *addr = channel->addr;
>> diff --git a/migration/cpr.c b/migration/cpr.c
>> index 0b01e25..6102d04 100644
>> --- a/migration/cpr.c
>> +++ b/migration/cpr.c
>> @@ -7,12 +7,14 @@
>>   #include "qemu/osdep.h"
>>   #include "qapi/error.h"
>> +#include "hw/vfio/vfio-device.h"
>>   #include "migration/cpr.h"
>>   #include "migration/misc.h"
>>   #include "migration/options.h"
>>   #include "migration/qemu-file.h"
>>   #include "migration/savevm.h"
>>   #include "migration/vmstate.h"
>> +#include "system/kvm.h"
>>   #include "system/runstate.h"
>>   #include "trace.h"
>> @@ -252,3 +254,9 @@ bool cpr_needed_for_reuse(void *opaque)
>>       MigMode mode = migrate_mode();
>>       return mode == MIG_MODE_CPR_TRANSFER;
>>   }
>> +
>> +void cpr_kvm_close(void)
>> +{
>> +    kvm_close();
>> +    vfio_kvm_device_close();
>> +}
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 4697732..89e2026 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -337,6 +337,7 @@ void migration_object_init(void)
>>       ram_mig_init();
>>       dirty_bitmap_mig_init();
>> +    cpr_transfer_init();
>>       /* Initialize cpu throttle timers */
>>       cpu_throttle_init();
> 


