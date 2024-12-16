Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D45E77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 12:39:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNANg-0001rQ-5Z; Mon, 16 Dec 2024 07:39:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tNANe-0001rC-9Q
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 07:39:22 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tNANb-0002wd-7I
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 07:39:21 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BG9MqVk016412;
 Mon, 16 Dec 2024 12:39:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=cyViF1LHyNzgXulaXT3/4/TIXn5xMeCLewr0j31GD/M=; b=
 P5mo2ZnNOp2MmkLNSG/9SxtJHno921sD5xuZjQNOyK77eIxy4zFQRNmCPvKuQx/4
 PXjdeKE/xIi2QpWHoZy5TLFHWchXluWsM2vFWuIn0VfxSQhjXGWbOpSO6wmU8QSW
 J7oUiR9mcH24N9eMLJKKZ1J55BwBpNurTzogw8KGEQC8w6p9XVNIR0CyOUBx8bGC
 h0syJG5tzviTBz73uLW4zlOEVlwt4mFuiQjvcGKKXoPa7FS3U0N5SiQP+i4QVw9P
 8lnMcGU86aFFmSNDRxb5nD187mX+JqYR6D+2EQF4UBmMbXz8SDHjLCQjlhFQPDhV
 +cLu7+HieBkCKLUSDJdRGA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43h0ec34km-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Dec 2024 12:39:17 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BGAacxN018327; Mon, 16 Dec 2024 12:39:16 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 43h0f77d1a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Dec 2024 12:39:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DkwlivbU6SB6zUfZ3UyG9O+xInE9MToGt7wb9GuFe46DRjnWYKvX4AKLnYC9rbIxK1j4aI5LI01Lkpn8xDqG9Pf1n9OuH47dmoUCyW2JHMpEHGlt8qdLxUnZaJ8HkWFuHStTaFR7U3T4GPVb9Kre4vA83BsKfkxlXXN8ca4FrXlzw3s7NCn9gVKLO6bLMzGfvSM7fUxfLu0/1vsjapvQJTPq/4rSl8eVaiTM7UjO/ofIt/Sqo2hRlFxF4zrXQY0whKeMkmvq76pD5f3sRB39CohtHK9xhRzeVI9nxunqtnl6514McV+G+Yg2sdrgz77Ys3fL6YRwgBKO8tFOoQjmkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cyViF1LHyNzgXulaXT3/4/TIXn5xMeCLewr0j31GD/M=;
 b=ZPWVtkv6Y8Ad08WxkmLNAB24yN3t8ho/NJUGTE+/hbl68t08r5vXpGKeJC2H7wXU4U8OwDQaxfmDMtkHXKEdJf4zm8yTajEQ6hCg9NFEXkaR1TlgWCNkwpctaqG5IWrDk0Czo8OnWsOPlNSBdGMtLLxrbIMqTqHRU0MQzzMK2zBMikh5J9XKFkRuICyglnQvVscXmAULf4XHhaOojTGwa9G9818XQZTejQhjaYB0i94uBR66J9NhJXaGYCy9Ls5Ya89vfDDIhQ3jYQ6qXOjIm0sVkTKVbEniOb2YLBauJFMusMFnv5ERZDb3dJ99KazHojkEobAIveamWTXQdgooEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cyViF1LHyNzgXulaXT3/4/TIXn5xMeCLewr0j31GD/M=;
 b=poCjuhkxxf2iDzkoXU058CLJ+UB2vXNRGTJvfJaloS0Q8lzkYhhuPV9eOwQ8hW3vqO0e00p+21cAL4HLF19deMhbFjp5EEfUG0p8uRQXZ6mCeBNMdbRs1WYMB/uK9l12G5KiSIsA96BTgFOAYyKZx+f8ROE2IJYV8yd9SsChR7U=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by SJ2PR10MB7653.namprd10.prod.outlook.com (2603:10b6:a03:542::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.20; Mon, 16 Dec
 2024 12:39:13 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%6]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 12:39:13 +0000
Message-ID: <8370d8be-a327-442c-aba6-0f43651aa08c@oracle.com>
Date: Mon, 16 Dec 2024 12:39:04 +0000
Subject: Re: [PATCH 2/9] vfio/migration: Refactor
 vfio_devices_all_dirty_tracking() logic
From: Joao Martins <joao.m.martins@oracle.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hyman Huang <yong.huang@smartx.com>, Maor Gottlieb <maorg@nvidia.com>,
 qemu-devel@nongnu.org
References: <20241216094638.26406-1-avihaih@nvidia.com>
 <20241216094638.26406-3-avihaih@nvidia.com>
 <7fdc0511-7a31-4e75-a873-c4c67edbc08b@oracle.com>
Content-Language: en-US
In-Reply-To: <7fdc0511-7a31-4e75-a873-c4c67edbc08b@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0203.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::10) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|SJ2PR10MB7653:EE_
X-MS-Office365-Filtering-Correlation-Id: 36a0f620-7231-479c-dfea-08dd1dcea529
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N1lwS3F2YXgzeFhnQTNPakhCYVhHSWZPd3BNNjBmT0draTM2Q2MzeXJQTW1n?=
 =?utf-8?B?MWEwRnBrUFIzVjZoRzZIYlhwaWlqMHo3czduUDJBMG5TNDNuWXltcURnYkdn?=
 =?utf-8?B?cjVkRzZ3U0hZTThGRklCU2ZqWm0ydWFsYXBUOFZ2MjdENVpibGlhVENTWHBl?=
 =?utf-8?B?dmpPRUEyQ2ZBNUxIZVlQbDhqblNiR0VPS3pYQlJ0TmxUMTNPOVFqY0ZQVXdH?=
 =?utf-8?B?WmNNeEgybUt1N2RKUmlTeE03bDcxTnpvZC9WNWxGbktFMVpHNDkwSFBHVngy?=
 =?utf-8?B?SENQSTBmUnA5Sm1tUDBLdnVCYWREcDYxbHFtUzdIdmFFS0Vna1EvVzNEekI1?=
 =?utf-8?B?YTNLVDc1SUJSSHN3VDRrajU5NTdPeTEySTVKd2RrRGJ6MDI4Z2FUOC9iZ05r?=
 =?utf-8?B?Y2ZmZ1JmRXM2Tk52NmdNTkU2S09wTmNRSlNwZS85VmVidllLZEc0dHdqOTMx?=
 =?utf-8?B?OE4xQzNQdDU0MnduUlpPZGowdXNsMGFaNTM4QUxxVjFSYjQ5UkxTUXYwNEll?=
 =?utf-8?B?eUZ5anU3bHpNTVRYTW93RzN2cUc1MVl3cllzc09qa1E4VVVyQ1NoL0cxM1NU?=
 =?utf-8?B?TGthU2xUcDhneUp6d3Zmai8zU2VKd3pvRmpFQ1o4V0Q0WUFweUxVNklVTXFv?=
 =?utf-8?B?RUM4ek8zaCsvTW9hYm4yTGtjMGZwQWNpOStRVlNpcXVjVk1KUlBFZlpCU3lq?=
 =?utf-8?B?RWlXdVBKMzBLYkVCTGMxL2xqWEptSTkyMmo3VjVITC80eHZQalo4TGRoV250?=
 =?utf-8?B?VHdhbU9Weml1UEhtbDF5cUtwbkNPVnhQcGZ3K1NDTW80S1A1ZWM4SnZPQzlW?=
 =?utf-8?B?STJMM0xTRDhCT1duOFVmcGsvbmh5K2Z3QnBEczhzcGQ3SmVpUTNxeUQ3RGpk?=
 =?utf-8?B?RXErUnNUMTNFNnh6UkxQOUFvUFJUMno3QjNTck5Fc0dEMjZ1VGVNTlFVZnVt?=
 =?utf-8?B?bjZoQWRXUHJWcDFvMnNSa0tMdWFTaWJ5ODU1UjJPV3lmc1g5dVNsMWpOTGRa?=
 =?utf-8?B?dlpjcVFnejB3VXR1MFRwL0F6MlFvL1VPRXQ0N0RYRzQ0V3g4djBKbWVRclpn?=
 =?utf-8?B?UlgxdzJXQWFqdklKc044VXRrUkcrQzVNdE5PYVJYTXAzejJUckNnRGlJRXFp?=
 =?utf-8?B?blA4QS9UOTlidWxNdGczTTBFN3NacDVUMDAyQ0lBMFVsRWV0a2dXUjFWc1M1?=
 =?utf-8?B?QmNIZlVPeFFvRzlpMmJDMXJyOWEzOXpIOWhraXZtYlR4N2hqS2s3L3h2Y2tQ?=
 =?utf-8?B?L2E4VG1mNU43b1lxeXh5Q0N4OGpTYlRNVlQ5TkdFbEZ1QzhRLzBLcTlaTjI0?=
 =?utf-8?B?T09yTnBZQlJnODBhb0xCQ2dvV0VDR2dnWXdYL0ROVDRMYVFrYm1IdUVxTVc5?=
 =?utf-8?B?K2ZESEZ1di9LMnQ0RDJwNjVjV1VUajl6QnAwdzhYbXE1bnRmUnlDdlYxQWxj?=
 =?utf-8?B?N0ZKci9EQ3V2cUo4UGRqNXg0cE1VYTY5SjlaaVhuUXFQRzhHTDlsSGdydzJq?=
 =?utf-8?B?OWVMcUJZY0Y1Z0ZUVTRKbEMva245RlFqMXJJdkpzaExhc2dZSXVEaWMzZEZ2?=
 =?utf-8?B?dkZCRVVNam9SSi9YWG11ZVdySGwwVUpBY1p2U050eEhNeDQxK014bTJPeGNQ?=
 =?utf-8?B?L0c1UitGajlDMmwra3V0RkZ6WXdTWGJFV1JoZ3VRK24vNlMwSkxRUCtSOWFs?=
 =?utf-8?B?aWczcmM5bDRDZkR4b3FhWnJEa1dkMEtrNkhzWFUrSHFsbXZyUk84MkdDSUo2?=
 =?utf-8?B?ZE5lazlhVHNuR3UzcE9JMFVmaUN6dWRqejNGNm9BS3lwYm9NVHNYc3pGN3h4?=
 =?utf-8?B?R2JiWFFHU2xmcHpJWXhrT1pHVk56emx2YWpLMHJUNURPYktyNitTaUNTRzdO?=
 =?utf-8?Q?I9JXgbGPI+YQT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXM3cHJSb2VGR3JwN0tETGROVkNPSVlKa0oxMDNwV0ZRRVNUR0RQZnpNVEpC?=
 =?utf-8?B?UitHWTBTd29OVFJCbElYVE5XQjBoWTlkc3JpeFJYb3A0ZXRTaFpEeTd2d2Zw?=
 =?utf-8?B?eXVtcXZWYXpzdzhkQlRkd3VqN2RHbmxpNTBxT0FyaEFIRC81NndtVmZQTDY3?=
 =?utf-8?B?SmM2V2JpRXpqRmlNWEFzRjljdXMvanNibHYvc2pmUHZmUVRoT21VU01YaGZs?=
 =?utf-8?B?bXhZclJWWENJb21UMjVHcWt4VlVzWjJUZzBieFpIazNDdG5saTJ5VlU1clov?=
 =?utf-8?B?SFFBbnpNbWNXc1JTc2NVNzN5MGNJdjZCR2R0RU9PQkd5Z2pDRnl6SzdLV3Fm?=
 =?utf-8?B?Y2ZubU9oRFVXaTRkcnVWT0lxbUVKYmh5bmJhbEtYUkU1ZDg3dFRLK01MRkFl?=
 =?utf-8?B?dkdYZXM4VFhFK0VkRFhEUWNhZElpenRJZHhFKzNhM2pUcWZmY1ZKSTFRZ2ZY?=
 =?utf-8?B?dmlqckR2VUNJNmM5VEJBRmpDTUlNVXZ5aUh0R283QVRoTDNqLy90MTFzaU5Z?=
 =?utf-8?B?TDVsS1M0SS84aWtnS3Z0QjFpSkZTcWdDRFZ1MGl4RjBIZHlkZEVZaWlOUE9I?=
 =?utf-8?B?b1prQTVTMW9JTG5OaHVoVDZFaFFCM1huNFBGYTFnOXFtR01nT2dQQy9PTTUx?=
 =?utf-8?B?aXJBNnQ5VnhjamVnVTJnNWwzOEVSeGRmc3RNVUZOaTNHdENyL2pzOXBsZVk0?=
 =?utf-8?B?OG9zcmlISHE4ZjhXL2FSK3ZDZGhKc25RQVJwSnRwWVJWN3pzbTlWbEJUcnpT?=
 =?utf-8?B?TG5HVG9ZemFwZWNCYjdRZlZFNkh6OEIzUWZZV21OdDVwVlFCTHRJUWl5SXBn?=
 =?utf-8?B?T1lhRFdxc3J3MFV4RWl3RmNtV0doZjNHZ2RLTVdnbnVCaEwyQWJMSU5XWFFZ?=
 =?utf-8?B?dHFuY0FaakIxZnlSNmtGN1ZOWnlubW1IWmY4dnluNkpjZUowZFBJbTZBcE9i?=
 =?utf-8?B?VW5uUXBrS2RZd1ZBN0tkbU1iQ0dSaHRjeHZuMWFFT0FsQjFmM0FvbnN3MTND?=
 =?utf-8?B?bnM2VXNPVTh5aXJ6bVhhUkFsQlg1M3FNUXNUbGE2YkVnUlpiaWM4Skk1TUZV?=
 =?utf-8?B?aEZVRWlqYmFHMExERmFoWUorQ3dPVmI4VjZhMHUrOUN3U1BLMi96K2YrV3F1?=
 =?utf-8?B?YW5QWmtkTE5EMkdCMkpoRlQwNXpTdk1yNHJNSDdVbFY1NUVXTWFUTGl2Tllp?=
 =?utf-8?B?Tmc5bzFaYzFLMWFpd2JHWXlPOWlNUWxwSXIyWTJxRk9Nc1YrTXRIWnJFUC9X?=
 =?utf-8?B?Nm1kVnFuVDZqaTBBMFoybW1kYUhDbXBlTjNwOHFpWTl2clA1czNrUUxIUE9Y?=
 =?utf-8?B?S3czbk9id25vTHFNTmJNVnBxR3NLQnA3dEw3T0FnVjFIcDl3dk1VdGZ3UE1E?=
 =?utf-8?B?WUM3L3NlWlFha1pUbWJKcXVKVEwrdVBDY0w2MDN0NitMU3NjMW9FVnhTN3hm?=
 =?utf-8?B?TktZZm9ocHZjc3lnRnRhd2xHL0NCdHhXQ1Jsd2d5UFQ3Sk5TM3E0SWJ2RGx0?=
 =?utf-8?B?SkRzV2R4WkFjc28rT2NNckQ5WkNWUVdyK0M5UitTa1Y3cktwWkhsSEtMNlR0?=
 =?utf-8?B?dXdreHBycnZITkhKSk1NSExpdjN1amw3cEQrR0kxblFzSlowNXlxU29vQ0NR?=
 =?utf-8?B?eEJwL2VZaDRGaHpFOFBleVRmRCttN0ZpbDVBVHc4ZTJ5eDlELy9yMXV4aHQx?=
 =?utf-8?B?LzlvNW1DYXhHcnpCdis4MDd2bWp6Y3cwYm1RakJPekhQc2NuUDEwVnRtOW5E?=
 =?utf-8?B?Wnd6WFlWbGY0T3lTcTRzTUQxTCs4NDhFNWx3S2p4TmgrcDVjcEFIZndLNi8v?=
 =?utf-8?B?cUJyUWpZUEZUSnpCU1p4UkFUOERLWExYWUF5ZHVwcExRcWhiNVNTT0VES21P?=
 =?utf-8?B?cFlYZ3VvVTgrdzV0WFhyenIwa2piTjZwTkNoU2hYZjVVNElYeTBhbXg0dURF?=
 =?utf-8?B?NGpGZmcyay93SERJSmllNmJ6aHlLenk5ZlNYQ0J6MlF5VUdSOUIweWpycUZP?=
 =?utf-8?B?SFg2dmh4WW5PMzZoZWlmRUtXcUFBNUtUN2pWRU1zVEZuZy82UHQ4ZVpWazlm?=
 =?utf-8?B?LzJFalRkaC9JbGlMUzZvTFVqUm5XUlArK3UzL3l6SDAra0JSUU5EY0x1R2Rn?=
 =?utf-8?B?YkphaVFRS3pxNUoxUHh4a0dEai8yOUR2TlJ4ZVVkUjd6MmFoSVFCbkdwUzRN?=
 =?utf-8?B?cEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TfkttijUqN6awfXfD/bjvCTE9STH9rUykebZi7DEUR3REG9Cix4NDy7VhX4JGefs1ZAZxJ6LcXKQNHzmwCLwjzwcieosajHCjkFZSG7xgDlxZkrXgGz2zfcEOf2yBht6Fw5d792KBEAoDhsjrJOwcdNkfthemf1Ts2RZmv2JGZwL6Yr26D2IJv3HvzfDd6ICY68ZCfoFkS4peownWsBtCeDkKUiRqeJgweCVIsJthrpPtTfcU1vjwzcDPxtTcHBnlDXzaA7dTZj3XsrLjS4DCLA83uzOZ/2xN8LCxpnwwBDGP7lM0k85/bQcliFJAtaa25PhxNJZnLinaDR5X8xALgWuOlOXm8Y6Kcl7pFyVw+0gBcfX7xNlcmYjLmXZZnjq1aoaPB7OozfQLWkCC5n75wnLE86Ivten8eblapCRyJqaxKuFLt07s8S4VwRzNMDN+tEQjAGay/DX3q38K3syBkVjs7+otK9tGfbsU0zdIqHL1gJdkMgCq7l5XPi8NfaIP038BXTWVgbf2Nb4/5YRHM9oIWiBt55wQYR5zhKT6xfvbbf1gYW4Nv6dsz2gP45IGrErkXwjB4XVfNL65iRwKMNEY0ftdZxQ3Fj8a+oTSNY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36a0f620-7231-479c-dfea-08dd1dcea529
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 12:39:13.0782 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mc/ny1roZzrp3LMAa/uLAZktV2NDF8mJBaKU8ZtZFrDg7EWPcAiYEn4GgtYKSvz3jGGpHEShW3efIfyYsSlLN0gM1r9xdeYIKtwcVmGNUHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7653
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-16_04,2024-12-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412160107
X-Proofpoint-GUID: lJjH3RD27jRNN8y5KjAYgpeNDd_cgtN9
X-Proofpoint-ORIG-GUID: lJjH3RD27jRNN8y5KjAYgpeNDd_cgtN9
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 16/12/2024 12:32, Joao Martins wrote:
> On 16/12/2024 09:46, Avihai Horon wrote:
>> During dirty page log sync, vfio_devices_all_dirty_tracking() is used to
>> check if dirty tracking has been started in order to avoid errors. The
>> current logic checks if migration is in ACTIVE or DEVICE states to
>> ensure dirty tracking has been started.
>>
>> However, recently there has been an effort to simplify the migration
>> status API and reduce it to a single migration_is_running() function.
>>
>> To accommodate this, refactor vfio_devices_all_dirty_tracking() logic so
>> it won't use migration_is_active() and migration_is_device(). Instead,
>> use internal VFIO dirty tracking flags.
>>
>> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> 
> The refactor itself is fine except a pre-existing bug:
> 
> 	Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
> 
>> ---
>>  hw/vfio/common.c | 21 ++++++++++++++++++++-
>>  1 file changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
>> index dcef44fe55..a99796403e 100644
>> --- a/hw/vfio/common.c
>> +++ b/hw/vfio/common.c
>> @@ -170,11 +170,30 @@ bool vfio_device_state_is_precopy(VFIODevice *vbasedev)
>>             migration->device_state == VFIO_DEVICE_STATE_PRE_COPY_P2P;
>>  }
>>  
>> +static bool vfio_devices_all_device_dirty_tracking_started(
>> +    const VFIOContainerBase *bcontainer)
>> +{
>> +    VFIODevice *vbasedev;
>> +
>> +    QLIST_FOREACH(vbasedev, &bcontainer->device_list, container_next) {
>> +        if (!vbasedev->dirty_tracking) {
>> +            return false;
>> +        }
>> +    }
>> +
>> +    return true;
>> +}
>> +
>>  static bool vfio_devices_all_dirty_tracking(VFIOContainerBase *bcontainer)
>>  {
>>      VFIODevice *vbasedev;
>>  
>> -    if (!migration_is_active() && !migration_is_device()) {
>> +    if (!migration_is_running()) {
>> +        return false;
>> +    }
>> +
> 
> Tieing to migration status means that non-KVM dirty trackers cannot be toggled
> unless somebody starts migration. When really your original intention behind
> commit ff180c6bd7 ("vfio/migration: Skip log_sync during migration SETUP state")
> was to avoid the setup state when you are indeed during a migration.
> 
> Now you can actually start/sync/stop dirty trackers without migration when you
> use calc-dirty-rate which is immensely useful to draw out how active a VM prior
> to starting migration.
> 
> The fix is simple and would be to flex the condition to be something like:
> 
> 	/* Migration status is 'none' with calc-dirty-rate */
> 	if (!migration_is_none() && !migration_is_running()) {
> 	    return false;
> 	}
> 
> This is ortoghonal to your series of course, but given you are skimming around
> this area, sounded like a good idea to raise this. This patch below is what I
> had plan to send when the development window started, but this was before folks
> wanted to unexport migration status helpers. What would be the alternative idea
> forward?
> 
> -------------------->8---------------------
> 
> From ace22f29a0547353e4ed5a0db53292a77f79fa81 Mon Sep 17 00:00:00 2001
> From: Joao Martins <joao.m.martins@oracle.com>
> Date: Wed, 9 Oct 2024 00:27:46 +0100
> Subject: [PATCH] vfio/migration: Allow dirty tracking reports with
>  MIGRATION_STATUS_NONE
> 
> Invoking calc-dirty-rate HMP/QMP method queries the VM dirty rate
> without starting a live migration, which is useful e.g. to understand how
> active guests are and even for testing purposes. calc-dirty-rate asks
> the dirty rate from the VM and it's not restricted to a particular dirty
> tracker.
> 
> However commit ff180c6bd7 ("vfio/migration: Skip log_sync during migration SETUP
> state")
> didn't consider this and currently restricts that VF/IOMMU dirty info when migration
> is active to allow it to be skipped during SETUP stage.
> 
> The vfio dirty tracker is already started, the reports are just skipped
> based on migration status. So change vfio_devices_all_dirty_tracking() such
> that we include MIGRATION_STATUS_NONE to cover calc-dirty-rate case.
> 
> Fixes: ff180c6bd7 ("vfio/migration: Skip log_sync during migration SETUP state")
> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> ---
>  hw/vfio/common.c         | 4 +++-
>  include/migration/misc.h | 1 +
>  migration/migration.c    | 7 +++++++
>  3 files changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/vfio/common.c b/hw/vfio/common.c
> index dcef44fe55be..0c188a2baac2 100644
> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -174,7 +174,9 @@ static bool
> vfio_devices_all_dirty_tracking(VFIOContainerBase *bcontainer)
>  {
>      VFIODevice *vbasedev;
> 
> -    if (!migration_is_active() && !migration_is_device()) {
> +    /* Migration status is 'none' with calc-dirty-rate */
> +    if (!migration_is_none() &&
> +        !migration_is_active() && !migration_is_device()) {
>          return false;
>      }
> 

NB: The patch is obviously incomplete given that I missed the check in
vfio_devices_all_running_and_mig_active()

> diff --git a/include/migration/misc.h b/include/migration/misc.h
> index 804eb23c0607..857768b51383 100644
> --- a/include/migration/misc.h
> +++ b/include/migration/misc.h
> @@ -53,6 +53,7 @@ void dump_vmstate_json_to_file(FILE *out_fp);
>  void migration_object_init(void);
>  void migration_shutdown(void);
> 
> +bool migration_is_none(void);
>  bool migration_is_active(void);
>  bool migration_is_device(void);
>  bool migration_is_running(void);
> diff --git a/migration/migration.c b/migration/migration.c
> index 8c5bd0a75c85..49d11e1adf04 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1637,6 +1637,13 @@ bool migration_in_bg_snapshot(void)
>      return migrate_background_snapshot() && migration_is_running();
>  }
> 
> +bool migration_is_none(void)
> +{
> +    MigrationState *s = current_migration;
> +
> +    return s->state == MIGRATION_STATUS_NONE;
> +}
> +
>  bool migration_is_active(void)
>  {
>      MigrationState *s = current_migration;
> --
> 2.39.3


