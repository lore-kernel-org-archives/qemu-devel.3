Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA47E7718B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Dec 2024 17:56:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPmeh-000802-Hj; Mon, 23 Dec 2024 12:55:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tPmed-0007zL-5H
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 12:55:43 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1tPmea-0006K1-0H
 for qemu-devel@nongnu.org; Mon, 23 Dec 2024 12:55:42 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BNGuk9v025707;
 Mon, 23 Dec 2024 17:55:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=
 corp-2023-11-20; bh=xzBxkSlEQLFGiPAnjeJc+DtkwQKRQyK954BiJyqfRIc=; b=
 PQZHG/eVuK7UneEUsnE43boYnO/uAfL8X0F70iiOyJ6fclzQAv/zeDAP4PrY6n0P
 Sc+jfbAgddLhYOgqTKcwSknOu2RXXbf11JEU81zxK7zHO3Aiw1kUg+rWHNxeR1R0
 mdQMET4N/4XnGFhsVQ/RKE+I9z2VU09xfYQPzgFaJds8H6Dq1r+lVzvagX09NNvh
 G2CAXLUih5KzRgTlWKR3fPN2be6oQxhfm/9h+nu2vXqUQawv3HVVfQiefthpoJlQ
 mlM7BdU5iv20Vt4VFXD19N20eZ5d4s9mS1J+KihI5Cy8Yv0Mh76t4gW0yDX87MHU
 k2HKXlf0rOUpP3IdfrPhUQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43nq6sb05v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Dec 2024 17:55:36 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 4BNH4T3d029612; Mon, 23 Dec 2024 17:55:35 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
 by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 43nm4debcp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Dec 2024 17:55:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wgKL0rOoVolgF44UGghtQPJjQnMnrZqZZr5FqksZIP4l081lJcnRkv5LVRRE6WyoiO3ivN1uzH+fxzoDFqc7cLtS7PtDWm2sn5yTd4v6H5nRgCjiOTVVPi63W2GQPAi8JpJf8uPrpPqKEzZaAk+MDW0KjOkKv3HKz5JEH/rdF4bkFUcE0LuPcpedXTWqCc3A/bUcpLn0qRrJjGG9N5LOMH0RedJjtO0S67jmd6rDiCZKzvPaHOIpZvMg/VPbsd/eoUx7/rQAspQWoW90y3deMKWyiar0nDH1+NAMvx78XbBdFt898+A3Iu6+ht07Me2WMISWCWcbSsdKeXuQjNUd/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzBxkSlEQLFGiPAnjeJc+DtkwQKRQyK954BiJyqfRIc=;
 b=cbfiJqOMg/zJnYf8y0c3dS/XJhiMDlrJ6sspzi2JFmLJ84asqRTYLNNA1bXm6LmzWjjfdz9J+HFLxs1mUJL3FK1b6z/TLroq0b0kL0Fxpj4Fa/y/C88OL3Ayagi4+kXE22dHzvnBj7AHc+AAO9zrcdlqok8d42Z+lmu5UoPpo1T/E0Eiju/s9bxc5CWbIWJnbPubiIw9157SdyTPL/sLg23TiY/uvEWT4XpNXvFBYJYiDrgwhd3Y/gFJsHNeNNG3e0SDipwMXcep7Gu8B/aN6yM5LXxk84DdivYue2xGDX/y7f8WAmUNVd17AIIQ6mMOExtrPgfBwJ5uNyyBBZfozg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzBxkSlEQLFGiPAnjeJc+DtkwQKRQyK954BiJyqfRIc=;
 b=P+roDJC7k2KiJEBXS2akYOXZ6NQHhKHA4d/G76SglHWTlvnEyBVsejN10HtWS8vIblXUHkea43cE/JFbL6Te67pHVKJttrFNvqKvcX2j6ZixePsx2Mz2/4P9s8fFdk7XUMBGEZG+yvLxkMQLMdptb+p1VUri/Y3tPBgi3gkJIlc=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by DS0PR10MB7397.namprd10.prod.outlook.com (2603:10b6:8:130::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Mon, 23 Dec
 2024 17:55:28 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%6]) with mapi id 15.20.8272.013; Mon, 23 Dec 2024
 17:55:28 +0000
Message-ID: <cc96d3e7-4362-461f-8398-bea956b22d73@oracle.com>
Date: Mon, 23 Dec 2024 17:55:19 +0000
Subject: Re: [PATCH v2 0/7] migration: Drop/unexport migration_is_device() and
 migration_is_active()
To: Avihai Horon <avihaih@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hyman Huang <yong.huang@smartx.com>, qemu-devel@nongnu.org,
 Maor Gottlieb <maorg@nvidia.com>
References: <20241218134022.21264-1-avihaih@nvidia.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <20241218134022.21264-1-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0173.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::42) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|DS0PR10MB7397:EE_
X-MS-Office365-Filtering-Correlation-Id: 623e65db-9d46-43d4-a9c5-08dd237afc4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?c1Z2K2Jac0xPNzYrQnpOclZYMmhEUFJIbkFUMlpMZEY1WXBpaHpXaHRqODhH?=
 =?utf-8?B?Zlc2N0VmbkVLVTJManZla2ZIUm1MUHVuQWRIYVhlZ2VzRHZxcVI0UkFNSmh2?=
 =?utf-8?B?bCtvUlArQ0h1M2MveERvdlZGZ0E5NlBTWXU3RHl6QktxUmNDaWc2NUVoUnFk?=
 =?utf-8?B?NndwdXNSWmw1cmxRbjB2TENYSitsTE9OOWRwL2V2LzAxV2p6UUFQcjlzU2Fy?=
 =?utf-8?B?dCtaZk4wdDV2VUZseGI5Vk56dm5WRVFUWVUyd0x6dWxnaGdtbGRvcjUxNXcz?=
 =?utf-8?B?WWF5WnpGdVpVMnpNNWYvOGtCdWFaSGNKUEkzM2RneVhEdk8zYmNuSGZGaWVl?=
 =?utf-8?B?TFlvcmcvZnF0MzE3bS9PZEwrUjgxbUNMSTJqVGFUQkFFK0QvN2RFcm9UTDJr?=
 =?utf-8?B?d2Zhdi85Qy9GdzcybFNrSFNTeTZUMDR0ZTRhc1Flcnk2QnJMbkJDbFg5akVR?=
 =?utf-8?B?eVhMRVVRZC9OdFp3KzhHK1hxYjFvUS94MFY0RUdCY3JTY05zWURJcjJ1K0Vk?=
 =?utf-8?B?ck85cFgrYVdEMVpNVWdRRndLSmNzaEpReUJ1U3N2YzBzSDhBQW90NnIwbjYx?=
 =?utf-8?B?dGlWdVNaazFuUVQwSmFUaWthcWJIT21YOXNieGhNampTclFyRnBXWXQrZWYx?=
 =?utf-8?B?ZUdpMHAwM0hlaDM5TGpQb3JzektzUEw3bHFLUi9mRDlzaWxvWUh2cVVldkNq?=
 =?utf-8?B?Vk1KTWVpRkIrNDVnb0RSdHh0dGhjSWpPcVZBdDg0VERYTFRpV09DZ25LRjc1?=
 =?utf-8?B?cStJN2E5WGVIQ3VORFdtdEpQZzUzY0NyTk5lcmJQQUpGdVAvMlZ4WlBUZDRq?=
 =?utf-8?B?WXcrUFVMdnh1azdZTkYwL0tPNzVnZnpkR3NDZC80VUJUb2FQbWhLODJScElJ?=
 =?utf-8?B?WWYxVy9OUzZMdktscExBWmZhTkkxUXYxZGZFR0o3Y3pPTUY4bGRUdjh0WjBG?=
 =?utf-8?B?ZFp0VE1vSm5HSzZwTkFaamNsVVdlSWt4RWt5N28wOEM2VnM1TUtDUUNaUGpW?=
 =?utf-8?B?NlpITE5SVzVBTG9nTG5sRE1XckZBTEYvaGxvT0RRTEtwaE5ZVWFsd3ltQ1FF?=
 =?utf-8?B?VWh5WVUraW8vUWxjcFgzak55SFpEY1lXci90VGN2bHcxQ01mN2hzNzJXNGhV?=
 =?utf-8?B?eDBBSkhBS0Z1OUpyOEEvRkkyalBwU2VNdjNtRzkxZlBXcHJQTTJSM3Yvd29m?=
 =?utf-8?B?bEhGUndPWG9uTXl2RGxWYU5oL1BYY05NWGZXWlNndmpTaGdiSXNlZHNvdXdP?=
 =?utf-8?B?L1BQZGQzY1RpMCtIUDBOdDZTN2FHTFhOeW1SRE9YbFcxeGhiV2laa1R3bDA2?=
 =?utf-8?B?Nm82bWhaVjYrdGlYYWhJcC90ZEVQdFNTS2VsQTNET2JGUXJvcDhWbTV5OWlY?=
 =?utf-8?B?TytNcGZNSU5PNzF0TUNybFFJdW93cHUzTDByOTlnRWh0QnUrREluTERvNldp?=
 =?utf-8?B?MjZ2M3A5UlpHQnhIZ1dCTzBIK25STHp3T3B0SlpEeFpUeEJjS3BuaTFpRWV6?=
 =?utf-8?B?T09CYStvbDROeFdnTlJPb0JVN1hpUTV3Y056dW9sYVd1YUxLVWtoako2dVpL?=
 =?utf-8?B?Ri9WUmdkYjBCTVJZWURPYlNmTXNJdGl5MGhMMndxcTVjWXA1b0NNY2U5b3Ra?=
 =?utf-8?B?OFpDaUFNWGZUWVVsV01QVGVXb0tXWitWb2IrM1lHQzFqRFhWcXdodS8vMlRh?=
 =?utf-8?B?R1M5ODU4TjZVYU5uQjZQTWtBQTVUTEpVeHVPS1BxekdrOFNjOHYwQzBBdDVD?=
 =?utf-8?B?WUd4QXJWNXpEcFlQSXY2REVBR0ZZcFE1TFhQZVhrYWdVVXg5UGl5V2FZSCs4?=
 =?utf-8?B?ckZnclh1TzBPcW1uNDVBcURpcmlNamdyUmxESHc2aitaaEc1ZlU4eE15WGNu?=
 =?utf-8?Q?myjU1KXT16x3u?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHYya2YzNlhFNVBsUzJhNG1RVVNlcWZjMDFXcjVIbXpoclU5S3lOUmtINFpR?=
 =?utf-8?B?Um1ISUw5aHVGeXZGQ2NsNE1ZQ0dZaVliM2tnNkREeXlLQ01ZL2FTS1NLbXhZ?=
 =?utf-8?B?VkRmZmRHMmRodW5uKzdOcWdGaEdyazd5M2hRK0sxRFQ0ZjkrRGV4RWtWUVho?=
 =?utf-8?B?OVVxM3h4aDhmalh5UWNqcWRzMkR3Y25HSGRPRDdpaGpsWUxnZTRPdklQQjVV?=
 =?utf-8?B?U1RHQWNPbms1eXpvZnVZbElFME41dElQQmVhOG1rMjRVSitRRzhxbHBTdHFG?=
 =?utf-8?B?Nmx2T21EWmo2TE5naEdOM3h0VzYzSkM5SlkwREc2WFhxeTh6RXgxdzh1MHVF?=
 =?utf-8?B?YUdJbnRWSEJVaWFYc0E2dTcycXljYzE5OHdQU01VSSt3NmhGdzM0Tll6RTVL?=
 =?utf-8?B?Zi8ycVJPTWl1aHM5elQxRDc1MFh4aGZ3cW9OUzArVHEyalo5Q3ZWRUo5OXdn?=
 =?utf-8?B?bTZPbUhCaDFoWW5PKzdISTBGZnRPQ0tOK0E1OTh1UnVxSHg5clN1UjhyOTM5?=
 =?utf-8?B?WHFKYWY1ak42KzlSenQvTncrbnpTTGtxUkZhcGxJUTE3QytmYkxXaGJhWDFD?=
 =?utf-8?B?a1FUN3Vac0pyQzV6dGEzWEp4ck1QdHpib00vejZzY21vRE1nS3FkVVRLRHNL?=
 =?utf-8?B?VWdkcmJtK0Y1ZGp6cTZWaWhqbEludXNCcHJhaWNwOGJsejlhc2dDSkxBQmJ4?=
 =?utf-8?B?UVJFUVBEM1A0aXRwRUhwUUJvZ3lFTXQzRDU3WHZLV1NDVVVYMk1tREFjNWhW?=
 =?utf-8?B?WEk3blVsTloyWitxK1NYWlA4OUlWVklBR3dWNlpkREZBZy9acEFHZDRMWXVs?=
 =?utf-8?B?aVFVOVpsTVFDdWx5MDVXOXNPZWYvVlpGVUJtaU9sdWJhcDBBZGducWpDSDJh?=
 =?utf-8?B?WEhhOGxTcmRZaDBGWUhxcGxoSEw4SUVGTnZoWWdhL3dwdGpWTGpROVpDQkMv?=
 =?utf-8?B?WExHOEZpY3pESWhhTTNkQTRYMThubG53QUVxaHR1MUZHeHBJVmdNKzlDSkln?=
 =?utf-8?B?WURoOVg4OTJVMjdJZmlFeEo1bFlJSmJiaDNvUEYvaTJpM1I0cGx1d3JoWm1k?=
 =?utf-8?B?Y1FsQldDWW93NXFGMERLb1VCYkxrZmVwcTJKekRsc0FJTHBHSEFtMVN4cll1?=
 =?utf-8?B?Y2M5MEk0WWRJODhmelZMWUcvQ2JCd3VNNjZRWk9iY0MybFlzVDhQWGFRVlpX?=
 =?utf-8?B?bkYvQ2oxWXJEYU1rZTZDTDJrTHFSK2dFOVhFNVFNVGVod1FxRThkK0JUS0NQ?=
 =?utf-8?B?N2lySE1xeWM2RGQ3eEJEWE1Cc25nSW40c21QUERLbW5KWDBSVkEwQUYxM3Mz?=
 =?utf-8?B?RHg1UEJKZ01KWGNVejBUQTdhR09wZlZxQytkTGJheTlpc05WcFFxQ0docDVG?=
 =?utf-8?B?WjRZSSt5U3duZnZYdEppVEwzM1FhREllZUlCWThXNUpOMUYzZXhQNWxNWXUr?=
 =?utf-8?B?dTNORzJwenljYVFiUWl5U2VabnlCMXBVaFBhY1NGa3VqY2FHL3p2NDg4QWg0?=
 =?utf-8?B?bFhQcUF1cHdWN3ZCc3BQL0xTK05QMzA3OGFjMzA0WE41Ty9WNFZlSjNtVWp1?=
 =?utf-8?B?TGNVS3JuR0t6OTV1Zi9MV3NVcTQ1UTB3ZmgrYXVjdFVnYktuRkFESXdOQTY0?=
 =?utf-8?B?akY0cjlQUGZGcjJwRmFJQWFabEc2alMxMG1vY1BMbUFMUmFLZXk4VjRxWTQr?=
 =?utf-8?B?dlNQWERUSzlud1NTZS9VWXVTQW1nRnNnRGpJcmZNRWdnVlY1YmpGSjluSEdN?=
 =?utf-8?B?b1VhUlI5SXNWVnFKSlNDQVNHbERSVGtxaUZqK29BWmM3QjQzdFB6aG5iRmJQ?=
 =?utf-8?B?YitBd0hqdFkvb0wzcVlzM041cmVpd2ZmalBGcFN4ek9GMHZVMzhHL2p3eHgx?=
 =?utf-8?B?YTUwK2c0L2UvRlpJL0VoQ2JmL3hiUWE3VmxiU1ZZZkI3citnWVJ5ZnJINUVn?=
 =?utf-8?B?aURNU0NXUVNZUEJsWHhtYlNpdlFKT0VLSTl6NzExaUdMOFIzZlJNOHJHLzUw?=
 =?utf-8?B?TkpEOStuRDJEWGdkdHEzWmVFTi9IMkNIczJnbExXLzhNbkZ0NG13bHEvdlNH?=
 =?utf-8?B?MGR6YTFyWUtXZ2VqVXNwK3luQ1ZCRnNJWnlOUythU3NzR2RnRWVTTWZ6aEV4?=
 =?utf-8?B?N3A5RWVaSExLTisydkxxYmUvWjJacFNzU0J0NmZpRUdQOGoxWlhVeXJhV3Jn?=
 =?utf-8?B?b1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: gRR0ji0VqqvUgjnzQwJH1/n5aNtjLunu9MMyC86YsdglGyHGDG/V7VlLniTkbFYcgE2wvRh20/HGzgCzqFCq7CCGknbWNih7np8VkkTiMAzVXCBWQTTXKi+pbUUjr5l1VHgkUQSdEuzXVABU/0aREcciRheLroFcumBbtzF2EJKhGHrpMa65+Jti6kTFWiGX6zDw1Tk0KXDkOuLyh8X26Q7HXVda9VVT6uwt6dtG5hJsKuTvRO9GUL5ddLquwFP2kLRAs6AG+kQxxBth3uRpl6pCo2S7+mr61JVVWW0vtVAa4zZ47AeXAbN7+yieSb/2YBUxG5ZVaTXxBO3HuOud48Aw3saZCdPncPjtw8ZKdt5x5DPdb6imjoj7kSPBhhBTVjZoIRpXU6iwfaUuxsGYoZvC9/tflzjPSpSl7m/Xs2BAElEGUrEcYuiRDHDGOqodXvnOw8NPs9CDE4iuvVX0pc78CYNSv+jQWYl95TbL14vH+ZwHHFSAUjpX9TFwtgY7kL4KYWGdOSf7fyLC0ZyauUimnCIUwp538lLAkOAGtx0dngs7ktjMj7wY7zG3JOV6Ycz1uuQFKlpKeFf8i+7jwrRCxdWAU3tedYyCKIYW1pI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 623e65db-9d46-43d4-a9c5-08dd237afc4b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2024 17:55:28.4790 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AlNV7C5aSJ64JCXWYB6y+2rHuSCeYNIltYvQtQAT0mpX7sSV6TFTGWV/MEifmkALoIAUlnA7e+DvQDQbtjhDRnkMmKJMpSW+CeXgVSh5e7A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7397
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-23_07,2024-12-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412230159
X-Proofpoint-ORIG-GUID: b4omj_Bx4Nw1-MdAFdn2ZBnvsJU6nNFJ
X-Proofpoint-GUID: b4omj_Bx4Nw1-MdAFdn2ZBnvsJU6nNFJ
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

On 18/12/2024 13:40, Avihai Horon wrote:
> Hello,
> 
> This follows up on Peter's series [1] to simplify migration status API
> to a single migration_is_running() function.
> 
> Peter's series tried to drop migration_is_device() and
> migration_is_active(), however VFIO used them to check if dirty page
> tracking has been started in order to avoid errors in log sync, so they
> couldn't simply be dropped without some preliminary cleanups.
> 
> This series handles these preliminary cleanups and eventually drops
> migration_is_device() and unexports migration_is_active().
> 
> The series has been migration tested with the following:
> - VFIO device dirty tracking.
> - Legacy VFIO iommu dirty tracking.
> - vIOMMU + Legacy VFIO iommu dirty tracking (migration with vIOMMU is
>   currently blocked, so I used a patched QEMU to allow it).
> 
> I also tested calc-dirty-rate as now VFIO dirty pages should be included
> in its report, and indeed they are.
> 
> I didn't test it with iommu DPT as I don't have access to such HW.
> It would be great if someone with the proper HW could test it.
> 
FWIW tested iommufd DPT (migration and calc-dirty-rate) on said compatible
hardware (Milan hardware). Things look to be working as expected. I deferred
vIOMMU IOMMUFD DPT testing to my own follow-up once I am back from vacation.

Thanks for fixing calc-dirty-rate along the way your cleanup!

	Joao

