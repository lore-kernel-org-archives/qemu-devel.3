Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32097C021BB
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 16:52:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmbfn-0003oV-TL; Mon, 24 Feb 2025 11:51:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tmbfl-0003o4-3E
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 11:51:13 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1tmbfh-0001y2-Hi
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 11:51:12 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OGXaLj013996;
 Mon, 24 Feb 2025 16:51:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=SC1+Aefi/8PAmmpcFDWdg/0r0AQkXmKCHf92qqceOig=; b=
 QMijp7wh/9hxQwyjvLb5HvUx4iCABpPuXBkwoWSTIhBL87m83tKF8pkEMEZquYNT
 rx2Rn9NrnRgl6aLdVSiEDHQTvXi4nSDu8goI4pMdtpxnb1n+UA+hr1wwg9TI8Ack
 459AGztx91460EPUL9O4t/hyTlL6Sy7D8qhK9lGjXkNTfcJz8xwrOQ3thFOW7meM
 tE9Wr9vfdom+YCBlEhnfp2JUErEh/7gUDCLBtscsqEbIe8Nfari0YK4ZPb5fiWQ6
 1JCmYRmNbHfZAr0qsciiisMd7Pj33B9l8qcjfT1lA8xg4FHA98i/LWsd/NXHH8/9
 QMzDcu9Lv/SAW5mRbnsoXw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y5603301-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2025 16:51:05 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 51OFcewv024391; Mon, 24 Feb 2025 16:51:04 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 44y517x1q4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2025 16:51:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JTZ5R+U+cPwTxOy6oZ5MmUS+HXQG7C3Z7bj54DxHkDZxXGthz+Hl/JvLofBWnjXysS6jZZyCLbWkHYl5sFS6PJVHMTMequLuSqwyi/jG9AG3ceNAL962fDyua8vrGFrdXGYfivqMFeAySSZEVhpy82GKPiQBLNbsmAKcPFGjJfHra60w3JlEd6h29FK/kuWU9hZmqt6zN8Z1qdvDHOy3sb1kHWWzpG62b33CQ3xVTtoW+Go5RdyeOPgFUMzCeeNYtejBC9k1CIvF0s2c90XIvrPWjXAE5C9LBgQEmxJcdhf5JfK7zPPZvcKfF6eyKvlYN2ldQX3beIjXG9bYWn1x2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SC1+Aefi/8PAmmpcFDWdg/0r0AQkXmKCHf92qqceOig=;
 b=G8jzhjvDIJZnpTh+/y6Dz9JfDYb+4ykRsUiqvnFJCeQSF6hobTDNHsaLjr5YAcBc0xAn9CXrCEUrVJUvw4Cxg0dEv4l7N5g6c6MZq71PDTKv15uYeObg2ivaJkNGQtje5CtVYpKaDCSJmlg+z2G6G+VwCLFZ4f1PnI7WU9WX7mXgXVZVflG3k2jdA8Wxge3X3LeKXfPOYYdqNMUOKynjjL6u+GFp4ECaipHbDiaOWjuCOLcCr89FAMMUG7j5F3I0Ok9IANcSQtnvjvaX3+Y4jV1IO6xKh4ImRm07jjghceQPSUwehtKsYyxhuigU9vnav1Js2BOc1AZ9q/71y6LrIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SC1+Aefi/8PAmmpcFDWdg/0r0AQkXmKCHf92qqceOig=;
 b=ierXo4jxV2nTD+4+vHveJmpU6fusfY7l+r6sfHeYKIrRiBNwWngEGG2ZjiwxFPiCLnHPMjFSftjG+sJ/p8C5Z6NSoWhFq5z5gvziHYKIDXiWrYIbkdkGVD3xcfp5gVfFlhRPiFrsd5mbU6zy25Nr6QyEwfq3EOiGYAL7C8bDyHg=
Received: from IA1PR10MB7447.namprd10.prod.outlook.com (2603:10b6:208:44c::10)
 by CY5PR10MB6095.namprd10.prod.outlook.com (2603:10b6:930:38::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.18; Mon, 24 Feb
 2025 16:50:59 +0000
Received: from IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572]) by IA1PR10MB7447.namprd10.prod.outlook.com
 ([fe80::f2fe:d6c6:70c4:4572%7]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 16:50:59 +0000
Message-ID: <4f6ac09b-7a58-418f-9212-da12b8412b6e@oracle.com>
Date: Mon, 24 Feb 2025 11:50:50 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 28/45] vfio: return mr from vfio_get_xlat_addr
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Yi Liu <yi.l.liu@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Zhenzhong Duan
 <zhenzhong.duan@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>
References: <1739542467-226739-1-git-send-email-steven.sistare@oracle.com>
 <1739542467-226739-29-git-send-email-steven.sistare@oracle.com>
 <Z69z6oTtaGOC287O@x1.local> <b6e19df6-cb38-4576-bdd0-6278997e402e@oracle.com>
 <Z6_G1rF7x2Nbzpl4@x1.local>
Content-Language: en-US
From: Steven Sistare <steven.sistare@oracle.com>
In-Reply-To: <Z6_G1rF7x2Nbzpl4@x1.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0005.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::10) To IA1PR10MB7447.namprd10.prod.outlook.com
 (2603:10b6:208:44c::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR10MB7447:EE_|CY5PR10MB6095:EE_
X-MS-Office365-Filtering-Correlation-Id: 377fd420-b524-4f1f-8e3a-08dd54f36a06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NTZCc0htaW10SWlBa2hHZGI1MXNXVDhEUzBxNXVpbGtlQU8wZDVJUzlHNkNw?=
 =?utf-8?B?Wnh1Ymg0bEo5NEdOSlNFMW5rekVHTXF6cG1BdUt2b1RZTWphUTlCdUpwSHRN?=
 =?utf-8?B?WW9sK3F2NTF2Tlp6YkIrdVlnRW8rbVF1TWd6SlJsdTM5YmtLb2FZNExxZ3p4?=
 =?utf-8?B?U1pWVkt5a0U4YVVxTnJxbEFMVmVmVlprMlRsREJjbVRsRTNzWjlXdXZQZ2pt?=
 =?utf-8?B?R0RCV0hibyszb0pLemJUT2N6VWJoOHcwM1kxQllQbFdoWHdmZWRacHpvWjRz?=
 =?utf-8?B?SEtYTDV0dFU0R1dNWU1FWGZlaXN6c0kzd2grNTlmeGdqdmh2VTA3UzVPR1NB?=
 =?utf-8?B?cEJiWjY1WWhxVStqa091cFptYU12SW1BZ0N6YjNNOGFkRVNpUTFtYk9jc0Js?=
 =?utf-8?B?QmRnZkQvNW5rWFBnRi9NcEhONjVxTUdBc0Rac1FuSnV3R0FoUm92TXEyR1ZD?=
 =?utf-8?B?Unp3QWZBODc5aDdDSmJzYkluVVFtVmRRb0VPT3JxM2JEWC9tVC9JQUpqYjBz?=
 =?utf-8?B?RDhuS1pyNTVMRjBVM0laeTFsYXY2Sjc5OTlZQTloaXVFWmRWYVNjOUdqTTRu?=
 =?utf-8?B?VnlKVTJBMDZRZ3FhdFo3WTQ1SHVUVWIwdFNoL0VibWpqMysreUcvQ2Nmd2xs?=
 =?utf-8?B?YVlEQ1lWMndWcTRMMnorTjFYY2h5SFBVYVcxdkVUQWJvWUQ3M2Y2MFdNUFdU?=
 =?utf-8?B?T1FTZGgxeHh5c3M0VGM0Zm5qSmZHaURWTlVKNVd1Uk5kNWY3d2V6Zzhsdnlo?=
 =?utf-8?B?T2FENFoySGhRVFZlOGJ6NjBLMnB5bFQrNDdGQXFTMTduY3pOZ0hRb0d0clRH?=
 =?utf-8?B?M3FGZ3dwZkhUbjJtTWVSMHNFMk90cld6UGErRTluR0JjSURKMlpZZGRuaEM5?=
 =?utf-8?B?RkN1elByTjVJVmQvMWp2bXJ4bnNaK1RVVlc1VUttRGNzbGViMmRxTUVmYjdX?=
 =?utf-8?B?ME9RQ2RwMkhBU0hiNGQ5Q1djdjF5Ulo2YUpPUnl4Q2JFSUx1RHRlQTFsS3RL?=
 =?utf-8?B?Vk1NVTFmV1FFTWRwOW5sYnVhY0JYYjFiN3VTOGNFU3YrTjFIaXo3V3oycktm?=
 =?utf-8?B?a2RFTFJKNXRZNkF3bEkrODlTTXhnRUhUR3hMbjVvQW9YRUQ4QkdaRTB3QmtC?=
 =?utf-8?B?VjVmbU83RDB4Tkk0YmwvSFBvTzE4ME1adUdCNEpJQTExM2lDaDZWcGpBT2FS?=
 =?utf-8?B?S3lFQ3RRYVBtYU5zcWQ1TGJUR1RIbnprRjg0aGtWMUlaTE96eWQzVWRjdVUy?=
 =?utf-8?B?OXAweXVUWkI0dk1JQ0F2b2E5WHdwczQxeVo3VVRvZnhTWnNVblZSUXFaUHB1?=
 =?utf-8?B?aGI3dEZzQzh6M2dldFF5anJmS3NHeEprakQ4NkpySHBDaXIvT05FNTFRK3F1?=
 =?utf-8?B?THBCZG5SWGRhSEN1M2gyT3p0R0VZT3dHUVhvNjFBRTgxS0tWeUVPNSt6aGE1?=
 =?utf-8?B?d2NmTFlTOVlTajBLMEhEU0tLSk9EdXJLc3VDRjYyb0YrVmFEMEpKclZBeWJP?=
 =?utf-8?B?K2tXY2xMVkw2d1FvTEtpRHJrYStiNEh4dEQ0aDVTM1Zua0g4MFp6Nk94dTc0?=
 =?utf-8?B?L0JPYkMweTMzbDMyZnc1VXVHOTArVEI3b2tsUUJKQTF0d1Rjbk9lZzZJOVBI?=
 =?utf-8?B?Zm81cVRraldUQVJmeUQ4SEEyUUFtcEt0dFNoTCtPVEI5UCtJYzloQnJPQmVa?=
 =?utf-8?B?L3hhQ3JOVTdDYnBQcGtmdlE3clBUaXNCWFlOQnhYL3UreUJ6L3lKb2lEYjRY?=
 =?utf-8?B?c2RBQUxzdkdsU2lMSERiU1JVWHh2TVJXY25nRjNxOGJ1bDh4bU1mcjEwM0xq?=
 =?utf-8?B?aWpvYmJ4ZkZ3YlhpUS82MGMwU2lOV3l5dC96U0lINFozdzhTRHRJOXhSQ0s5?=
 =?utf-8?Q?ba+zm5DdLY9gV?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR10MB7447.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTBKMzNPWndxanY4VVp1UmtzMnFhOFJKVXpwWlhhT3lkOGdwNTdBTzNVbWk1?=
 =?utf-8?B?Qll3NXdmTVpRZ1poUGVDU0RuNjQ4cm1WMGNGZDg4YTE4OWsrVlFIb1pvUmZF?=
 =?utf-8?B?TTFsbUNjaEJnYm56Qjh2UGlHSHlOQ1UrVm56YWQvazQ1WHJ6UUZwSnpUY3I5?=
 =?utf-8?B?MWRvekhONDRnMXNjcXhTbkJMVzd3YWRFVWp5TGZpMXBFRjJNOVdJMFZBRnFH?=
 =?utf-8?B?SHN6Nm1HbTdWVEt0dlJYWnZqdHlWYjBaVG9iaXJoUEZBbmgzZUloY1F4QVMz?=
 =?utf-8?B?MDB1c3kxak9tUzBUSC9CNHlsQUxnRnlRbTVsTWEra0FoK25ubURWb3RwZjhU?=
 =?utf-8?B?WUxCcW1BclVtcWJHWFNZd3lCOGo4UWt3S2xuMkVxUllralJCT3pZeUx2TmNa?=
 =?utf-8?B?TmMwUllIeldOZUxKZmx3STVETXlWU3FZc3Z6cHgwbDlGR3MyeHhKZFUrYUR1?=
 =?utf-8?B?MmJ5SlBsakdVY3JaV2dvZ0pnbTVIWURqcjE5UXRVcW1CVGt4ZlY2aHBBV3BT?=
 =?utf-8?B?aGU4Z1pxNExLSWVNNXE0VzhzeElDaDU5SXNSTHdEV1hLR2VxTjA3ZWJqOVg5?=
 =?utf-8?B?cFZHblc1R0VDWlNnYUJxemV6ZXpEb3gyRWkwN3N5Y1J2YXltejgyZDJaSTIr?=
 =?utf-8?B?ZDhwZnFBV3VRREk1ZHpNRDh4U0VZNWgzRjlnbjd4VGVIdTVaZk9DSWl5QUVz?=
 =?utf-8?B?WWN1bnhGcjd6RU9RaW1jWDRJa1VOMjBUUkx3VWhaQk9xTHZPMkhEOUtaM29o?=
 =?utf-8?B?VVpSdG92MmQ0US81UWt4dnlrWTFBakFEeGYzb2EyUVR5dWw2WlB6czJEVmxa?=
 =?utf-8?B?K1JhejVqcHVTMG51bC9UNVVPL3J0ZXplZ0tYdEhYUldWaUk0VmtDMFJyLzVu?=
 =?utf-8?B?Q2tTREE2eTE5ZVY0dE9Xb3YxcFYydlZPVHVIaUt4YTc3K3hPcm1FaVJWSWpR?=
 =?utf-8?B?STBuNlc1STRQM1U1Wk5UQTA1V1lTeEtuaENrRHJ3RE0yaGxONS9aUUhWRjVu?=
 =?utf-8?B?OTdGTU1udUFsbFgxdnY0Y0puODFLR2piUGY3K053ajU0UXlmWjczVEFMaklp?=
 =?utf-8?B?MnhGWHV6SlpIM1pVdWFHdDJpVThqZmdUazR2QjRiTjFkdkd0RzJ6WVdtbDVX?=
 =?utf-8?B?cFdueFZLWFZNKzNtMDF3V1IwYW1WaFBxTmdCR0R0NzFWZm5hZUR6cE12dWk4?=
 =?utf-8?B?TUd5ait1dEZJc096dnJjb21CRks1NCtrMmwxaS9PVGRCZi9VNzZ6dHluR2Jp?=
 =?utf-8?B?U3lIc1psTzVRcjdLSWlSOTFDNGZwVjJJWW8zdit2bWdIdEVuVTJjTmxDbHJn?=
 =?utf-8?B?eUpBMmY1VEZuNU1oTVdvWGZvVjhaajVnNHprZm1MKzRtY3NSUUx6WU9idnE4?=
 =?utf-8?B?T21vVEdFYTVhbzRDeTlsTVFxV25KakxwUE5LVFFXb0hXNHZRenZvYTYzU2o3?=
 =?utf-8?B?WTJvQjdhOTNYalIyU1FRam0vM0ZkMEs4TFc0ZXo5WVprSW1KeFVmSE9KTlJw?=
 =?utf-8?B?SXpOMmRQVE5qSDEyU0tYWC8veXh6akhqOFpiRjViQWhqWGx2QWI3aUdSbEtl?=
 =?utf-8?B?WDlWMEtLSWVFY29pSlc0VmRGR3dOSjVnSW5yck80VDA0Z0h5V2tYSHNDZWkz?=
 =?utf-8?B?QktLSGthYjVRWlV6Z05KdzBPV3U4ZEd5L2UxMmQ4TjBZSE1Ma3lXdjdoQk9B?=
 =?utf-8?B?RENFMjkzS0xQdkVhWU5RTjlCTE5MdGZMYUpORDJ4amZqU1ZsUSttVU12aEVq?=
 =?utf-8?B?UVNDU0o2Zm50MHppaTZxUEVwTzgzQmlINWI3bFhyQkE3bzZQakMrc1kyckxv?=
 =?utf-8?B?bHMwUFJ0U1BXeVltRXNocUovOEtEbTF3ZG9EYW9Jb0ZxWEEyc1h0NlFkN0sv?=
 =?utf-8?B?TXJ2bXpxRTdpMFYxTzlvbEszT3pDYnV1SytIQjdmT2o1YjJDTG5nd2JoY3JF?=
 =?utf-8?B?TGRUWDA2T09YdFg2QW82RVhPWE5MVFpyb1JJSjBRMTltRC90Sk1rK3IyNi9a?=
 =?utf-8?B?TEwwNFh4NFZ1Wlk2bFo3T0hQRGJ4WWtiZmV1aVV6N3ZORXQyQlJ6aWdJSk56?=
 =?utf-8?B?d0dxTUNVNlJHQ21WekxLRXdKckF2YUxEeVdoNUlwWjlrOFhsUzE5SVhjRE5Z?=
 =?utf-8?B?aFRkdE1xZWdtRC9IUjRLdjhUdS9RVllQOGxJU2FmZWV1Qlpja1pxQ0MzL25j?=
 =?utf-8?B?bEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: D5BVlY/O4jd5cNqKKyZSNE27ZyJFmr4depmrqJwHQCecqQuSDEL5xhu6gAcX+pbkDeYBCOrLDswC3nSGRaOxXByUAEax4wlCRSUqQ6kMo9sMuD4o0RmgN4wASTd99KDmUAScqFV2WBuA67SOKaWbf1/6q62MX7vMT5vMSYjIMq944OwgbWUjgljsgxuHz15BxtvnoCD+bEcSpCEwQHw5dTmN21J4FvU8NzJycSftX/70NsawKYvj1Z6KPnA2hFISVgiwxQe7zx84X/zh9nB1RGgMCH+Q3YjyhUXRXRZZevWGG/U9Kt2a0x6oZzJljEeAcsrlJ0dcdkubRzcdD/k55ocEopv9bgznT1v9MS058gKxUMzKwK1o+/DIoMfIL+NZzOuIOxnNrkmiI4mdbEz9iio3buDgpkO6E6QRbFbCSzpRzibM20mpCFlDRphxrqDPHGre69tpqMkdtsen3NnhY9sSpxi5EwRrmUTaMQA94xSymHFOC02S/ar9qWVUu259c9u4J9UVRfJovSwmcGNWT6Wprt4I0Z+zZL4FbF8TBjTXz4CzLGDin//4mhnVxmgio2iU0xit2m42/gkjdyAoHR+KKjCkLJGAw+BlZf0sUgo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 377fd420-b524-4f1f-8e3a-08dd54f36a06
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7447.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 16:50:59.1840 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ybz0UYqZ/doH8sLaqrRcm6P5MoBCixTdpnGnqXg2GrR8CQtgh8/nPV+97jme4kRgNmekT3SmsIvZJFitwGe0eoOWJ5v/10wD3VVCPXodD2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6095
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_08,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502240115
X-Proofpoint-GUID: qo1d4pbpQLg738wasMFFU-RvdqXNodYn
X-Proofpoint-ORIG-GUID: qo1d4pbpQLg738wasMFFU-RvdqXNodYn
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=steven.sistare@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 2/14/2025 5:42 PM, Peter Xu wrote:
> On Fri, Feb 14, 2025 at 03:40:57PM -0500, Steven Sistare wrote:
>>>> diff --git a/system/memory.c b/system/memory.c
>>>> index 4c82979..755eafe 100644
>>>> --- a/system/memory.c
>>>> +++ b/system/memory.c
>>>> @@ -2183,9 +2183,8 @@ void ram_discard_manager_unregister_listener(RamDiscardManager *rdm,
>>>>    }
>>>>    /* Called with rcu_read_lock held.  */
>>>> -bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>>>> -                          ram_addr_t *ram_addr, bool *read_only,
>>>> -                          bool *mr_has_discard_manager, Error **errp)
>>>> +bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, bool *mr_has_discard_manager,
>>>> +                          MemoryRegion **mr_p, hwaddr *xlat_p, Error **errp)
>>>
>>> If we're going to return the MR anyway, probably we can drop
>>> mr_has_discard_manager altogether..
>>
>> To hoist mr_has_discard_manager to the vfio caller, I would need to return len.
>> Your call.
> 
> I meant only dropping mr_has_discard_manager parameter from the function
> interface, not the ram_discard_manager_is_populated() check.

Got it, will do.

>>>>    {
>>>>        MemoryRegion *mr;
>>>>        hwaddr xlat;
>>>> @@ -2238,18 +2237,8 @@ bool memory_get_xlat_addr(IOMMUTLBEntry *iotlb, void **vaddr,
>>>>            return false;
>>>>        }
>>>> -    if (vaddr) {
>>>> -        *vaddr = memory_region_get_ram_ptr(mr) + xlat;
>>>> -    }
>>>> -
>>>> -    if (ram_addr) {
>>>> -        *ram_addr = memory_region_get_ram_addr(mr) + xlat;
>>>> -    }
>>>> -
>>>> -    if (read_only) {
>>>> -        *read_only = !writable || mr->readonly;
>>>> -    }
>>>> -
>>>> +    *xlat_p = xlat;
>>>> +    *mr_p = mr;
>>>
>>> I suppose current use on the callers are still under RCU so looks ok, but
>>> that'll need to be rich-documented.
>>
>> I can do that, or ...
>>
>>> Better way is always taking a MR reference when the MR pointer is returned,
>>> with memory_region_ref().  Then it is even valid if by accident accessed
>>> after rcu_read_unlock(), and caller should unref() after use.
>>
>> I can do that, but it would add cycles.  Is this considered a high performance
>> path that may be called frequently?
> 
> AFAICT, any vIOMMU mapping isn't high perf path.  In this specific path,
> the refcount op should be buried in any dma map operations..

memory_region_ref contains a comment that implies we should avoid taking a
ref if possible:
      * Memory regions without an owner are supposed to never go away;
      * we do not ref/unref them because it slows down DMA sensibly.

- Steve

> Personally I slightly prefer this one because it's always safer to take a
> refcount along with a pointer.. easier to follow.

