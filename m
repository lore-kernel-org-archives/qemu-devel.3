Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 044AFC3DA45
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 09:56:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRU3o-0007Mr-Dw; Wed, 10 Jul 2024 05:56:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sRU3l-0007LJ-Vx
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 05:56:26 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sRU3j-0006Yf-Kd
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 05:56:25 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A7fUec003976;
 Wed, 10 Jul 2024 09:56:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=hEHvaStvIyZgSwfhwNj8nsgGTmqC9lHdycym+W3q5DI=; b=
 P0o2Nsne+1frNbw4vb9LmCPHmpJvu0elUfZAMAMYiNSE03vXkX9nl1PN/oOVXW6s
 uG8wZmgh8GbNd6rhYjYvcHdZnh8JJ62nwOFawwwm+89Cj42QgtvsaYy+GOA8173t
 NadgxmEd5IL4nEvCeLNbJGBtypT1oCd84XdJBYGMga8zKqdf/CXw0Dh0a4/4t00t
 ciSvkN5bBVOKgQJm9xnqwe0bB05nxfFZghVZX5f9JQkhNvZomeGoyu/znplBhoNT
 sfV3dKxRfwzLY0qqqOZUHuPhR61rkUzyYSOhtcHHHFnpJ/Idp65fAKM1IW5kD77X
 +EU8Oc6cyVZ12K7aFamWlg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406xfspw5e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Jul 2024 09:56:19 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46A97NAA027500; Wed, 10 Jul 2024 09:56:19 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com
 (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
 by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 407ttuydvk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Jul 2024 09:56:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UqQjxcaiBR9av8a4vTQaWioHHISnUGcgL5WdTK6pE3G1qcsiSEA9ZkDHeJt+cP5DCLeAKVA4Y0yQ4pBPPULl7kmy9SjXhKODW5zlL5kB0kYcjr3isKCQUPrAVrmi6IAUxyLvrEJsMqetgwNvcdRR46sI5BQdFyqV2d+Zs1IzYbPHirhKGuYOn95yidVhEhe65Boe/twLuYGoq9JTIe3Z+bV5sA0HTTpmjXOS077EtVCXD4w/fz1oN9CBzV5Fvt/AiXT3RR1Os+Xw5SZzWZchXoeTqkdWZVEnPxWyqb8G59z4b9vGIvKOMvJ8nFtqj/0ZNWEAUnuuZN3j92Nku0lWXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hEHvaStvIyZgSwfhwNj8nsgGTmqC9lHdycym+W3q5DI=;
 b=PLzpgeMuUqj6aoJpOo65sx4fbqKBnqD6MIUmHKOZP0d+VFxDKOIwsyHIfNuShcd5qEZjw/g7dEdDvCahDwlpUOZjF3NFcavMthWnzPAiDD3ZvxBhSrQNRyaQVJLKm1Pdj4SjJzwOUm4U+o+9sVx87vCrBJuaF2U8GanWca8EZ2SHVuMMjOtt4E2bOZIF6xY4/UBdgbDc8PjmSkfXkmOkFgOtslqLIOazha3JJ0Jug3x87yTHIXjwtI8bMhLEOX9lc4GFGQddkeWAtKxdDpvGJ/1hP8qbfayuI+BEYXKKLWUwiVsk7Je/dlzIcElz1KrGmfKSIkmj7UtrP6f8pfDB1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hEHvaStvIyZgSwfhwNj8nsgGTmqC9lHdycym+W3q5DI=;
 b=vsqbVshjHBtz3YV9OexoDEscTi5u67bB+G5dqHI+gziM7C5Rrnmta6GgygxcxfbVdTex3UFbTRyysctTERCP70iOdbiLYILqGVXcpCsGgEWR9+gX60n9Pj5Cm60PcGxipWXnbEzk9JiNNLxpa1zj95zEROgozxqNxi3YRQEmDg4=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by BLAPR10MB4899.namprd10.prod.outlook.com (2603:10b6:208:323::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Wed, 10 Jul
 2024 09:56:16 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%6]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 09:56:16 +0000
Message-ID: <9bebf131-a465-48d7-a52a-15094576ca01@oracle.com>
Date: Wed, 10 Jul 2024 10:56:05 +0100
Subject: Re: [PATCH v3 01/10] vfio/iommufd: Don't fail to realize on
 IOMMU_GET_HW_INFO failure
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Avihai Horon <avihaih@nvidia.com>
References: <20240708143420.16953-1-joao.m.martins@oracle.com>
 <20240708143420.16953-2-joao.m.martins@oracle.com>
 <SJ0PR11MB67440E96F272F5D349023AEB92DB2@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <e822d50d-8147-4846-94bf-fd32cb1aff99@oracle.com>
 <59a63429-831b-4bcd-b805-9fb83b8bcdd0@oracle.com>
 <47f86137-a47a-4fa7-a899-39c8f3bf4cbf@oracle.com>
 <SJ0PR11MB6744E07A01918228E5F4068792A42@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <97858274-3e67-4908-8119-a1ef9b6a092f@oracle.com>
 <SJ0PR11MB674411EFA02886F23B1222C392A42@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <SJ0PR11MB674411EFA02886F23B1222C392A42@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0179.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::48) To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|BLAPR10MB4899:EE_
X-MS-Office365-Filtering-Correlation-Id: 104268f6-3669-44d2-1199-08dca0c68a4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OVJwWkUvVlo0NWFMbTcrbVFkMHRGWC9CTmxBMnhMSmZML3oweWErOXpjYldl?=
 =?utf-8?B?NkxzMWNFeXBiVW1sTkJ2Y2NUT042ZGVRY09QdUtCZ1JKZm9UZk9XVi9lYVZO?=
 =?utf-8?B?WCtYN2dYNEM4UjUxQ003UXRlYy9oRG5YMzl0ZG5pSy9BRHY4STd0eERPcjhE?=
 =?utf-8?B?UXY3OVVRVjNsRmhoZ3dHZkpwL3dvN1BUajhVR3k0S0hZa2lWTE9sbEtDZHRV?=
 =?utf-8?B?YjZ3aUtsbHB1amp3VjBRYUw1YVlWVmt0V0k3Mkh4VU9zVSs5SERaQnNoUWk2?=
 =?utf-8?B?Tm5SSnNGODlPUGVjc0pOeUl5d2tVR0hIeWhlQ1Nlcy9MR0ZOTG5VYXpFUHBP?=
 =?utf-8?B?RUVCUFFwb1B3elVOVWZ3N0ZLaS9IS1pFY1RKVmh1Q05CbSsxamk0OFRBV1Fy?=
 =?utf-8?B?cjlOLzAyQWFQV0tROHZ2RnFCbjcwT3liVWJOcWIwY25YWXZ2WGZGUnRCNWNK?=
 =?utf-8?B?S2tGZ3ZuSG51bnFlL1RpeEp5QXJpdEVaOFFrMWJlaFJ5QlBHblpmNWFySXBk?=
 =?utf-8?B?VzdvYTF1MjFQOTQ1b1ZZZElFV0hvRlNLOFAxV3VIWTJ1TnF6TDB6cnJ3ZXJU?=
 =?utf-8?B?dEpBclUzVlJpRFhDRCt4cDQ0eGtKakxIUEx1QnRhWXFmZkZNenpFam5qOE9k?=
 =?utf-8?B?T3FVUW9EanMwMTVqeG5KSGlCL05lMGpRQmR2d2JHQ05mT0NFbUNXbFljRlRL?=
 =?utf-8?B?VWZqcE5vTnBveW9DczJpTzB3MElMZUt2VzYyRjBDVm9ubDk1MFVwTGFZVi9K?=
 =?utf-8?B?cjd5YTh1YnVxYXV6eE5EQ3FYTERkZnpzQTBmbE1mN2xvLzZjdU14bWRDcG9G?=
 =?utf-8?B?Z2VSbjVTYmswY0VaUzdtK202bzBxWmpTK0o0L29mY2RPOWd0WVZRbEZSL2Fr?=
 =?utf-8?B?NVFSWmNOeTdTYlZpUUhBQmNFYS9zMzZYcnJOOWQrVEEwektyZDlsdVVtc1JD?=
 =?utf-8?B?QXp0YVNmUC9IZmliVjdiSmEwL2xXaU1ZZTZxNlJsYzVPZzhWR0FOWVpZMDJH?=
 =?utf-8?B?QWZOSzZuU0FSbHdRT01uSkVMbjhBRmNpaVJ2VS81VW5iNjFFU0lTVzlDTW5R?=
 =?utf-8?B?SVA5eTdZUm5XQTBObGZwYjl3UndhRXJ3VnJubEkzQ0tIeVdnTWdDaFhtWERa?=
 =?utf-8?B?NkpsZVJnZTU5UVhPV1JIaTNBVU9UVFRqRmtxdGxvNUZoMDlZSnhoNW5jUUVs?=
 =?utf-8?B?amorZDhVY2w3alB0VWQ3Y2dZaC91TGp0MkFXVURoRUNTYWpNQUtGSnF3WjF6?=
 =?utf-8?B?NWlkQ3Q1WmhzSURUWEJabVF0TmY1NXE3bnc4c2lISlk3Y2czL2kyd085NGJS?=
 =?utf-8?B?OXpZUmJOb0NySlBwNUpsVHNkazZQY2dOVXozcFErWml1K3MrTmxWUGs5K2o2?=
 =?utf-8?B?Znp5Vk5PS2RIZ1gxdjJycFpmcWJpcXBJcWIyRzRrdlJpbzA1MVViYnh0L0xI?=
 =?utf-8?B?SENwM0ZEQnowcWgxZEYycFR1SUxPeGthcW9nbTV5ZDJHQ252MzNtNUJBOTQ1?=
 =?utf-8?B?Ky90dC95a28zeFU1MDBwbzArNTBnNERSdkU5ODF6Vk9CeFYwdUY5MHpFcFRQ?=
 =?utf-8?B?b0dscHd5UU5sSXJYSWxLRXNHZHZNOFBCLzBvZTNqYitzelIremNjRkVIRGE5?=
 =?utf-8?B?ZzEwTmt3Sis2OWVKQVRxT0p1b1NyVCtWeHpzbEw2RWUxVndCblNYYlBhaGZn?=
 =?utf-8?B?MU1lKzNVaVFycVpVL1NjUExRWXI5ZUtjUHptWjNMUW1DVDhad2ZLamUwU2Z6?=
 =?utf-8?Q?rQoJqPuosFPwFJSlic=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eStEZEU5T1VFTHlIRjkzRWNteTlOR25tMTZGV0JBNXFnYkFKSDF4WmtMSkl6?=
 =?utf-8?B?ektoVmlITysvQzFaWjdteDBPdHZYeDZpWjViU3dyZ2ZUWXZCMXE5RU9RK3ZO?=
 =?utf-8?B?dUlyYmhYTHVmOG1oWEFTWHJxMzBURXp5N1E4bDRoTDRNMUdlY3ZQQ21YQTd3?=
 =?utf-8?B?OXdkNEMwZjAwR081djNMZmh2aFpjOHpmNlZwK29zRnFJZ3loeWZiTVlwN1E4?=
 =?utf-8?B?Tm54Q2pWVVZVRTBtUnhvZnZ1dVhrTm1xSnA2a2FXWFR4bHVaS2dLRkZPVHlP?=
 =?utf-8?B?UnZYUEFRdEhPdjY4YUNjdHhKMzFIWFhkN242dkkzV0EwZk16TysyYUtPRFFF?=
 =?utf-8?B?WFhnVlVrK2xrVUtSV0psWFVPSldQbHJnQXNValhIY3pDL3hFYXM1ZkRVMjV2?=
 =?utf-8?B?bWFWWVlod1NMeXhHbWlZM2ZTYitWU28wc2UzalVMdUZDR1lPS1NweHRuU2N6?=
 =?utf-8?B?OHZhWGpNeDE2a3duUHBmZXB2WFdzNnJOb3NTcENMejdoSnVpT3JBNi9HekxW?=
 =?utf-8?B?YTA2STRPSEpyUDdnTC9IWC9wVVlsZXR0RFFjMzdrSXh2bEJpd0s4ejJOTzYy?=
 =?utf-8?B?ck5OVnYyWXcvekpvNnZiM2tMd2tybmcycUxuNUNXdVFZZ3JDOFB2ODBScENQ?=
 =?utf-8?B?MGo4NW0zTlZ5M0h2V2FWY0g0bGh5a3VuREkyR2FjbjhaM2VCRVBrZjg5UTJR?=
 =?utf-8?B?aGpIdWV0NnFFbE1YUFQ0OHMvZ0xSQXZWYU5DNjdFZ3FDWDQ4VDB5M2ZEWVdH?=
 =?utf-8?B?Vm1MdEZ3b3hvSDh2WnA5TlFzUWliV1BJYWVkMDVsb2l1L3R5em5rVlkwUkxq?=
 =?utf-8?B?SHdyeld4N0VzY0k0UFI3eUdzbzVxR3NLZEs4YzVxVkVyejFZd0dzV0xtdlJI?=
 =?utf-8?B?dFBXNFNiQS9UZHRweThERXV5N3BRVTlDNGdNSkpjZFZ5dHllYy82YTFKZ080?=
 =?utf-8?B?OGNLWngwNkYxbS9DZ2xKMmJNbWRIZmxQeHlXWHBCY0oxVUxWb0IvSE5PUGVD?=
 =?utf-8?B?SDVKemloSG8wYm5OdGlwSlkyTEljbUk5VTNWY2xlVlM3T0pnV1RPSVRkVTdm?=
 =?utf-8?B?S2ZtTjJkRzdlMllLUzlCSjd2QURTVWxHclg3T1NBK3MxNlY3eGZNZk1PaWhH?=
 =?utf-8?B?eWxZRnJpM1pDYmRDQXpuWnZ0RGJ4aTlBZjdUNnk0VVZ4NGdLRzltZWtKZFJj?=
 =?utf-8?B?RkRzbUZVcnpFaW5TT1ZHWnVJTFA4RzY5VHNSMk5ZSjVsUFhsaEQ5dEJ4SzdG?=
 =?utf-8?B?azc1VS9HUlkvRlRsSnZvMm9kdUptL01iSHZtS1JOWDVmUFlrcGtDNXpDNllP?=
 =?utf-8?B?N1ZjQkhrekFlZ1BsZnFSVWYvMm82N3F0Vm5XeDk0eTZyNFhmV1VCTk4zUGFt?=
 =?utf-8?B?cHBxcHQzdGs0S1pCVFVlL1lORU42bnNwcTNIME5TcXRibzVxa1F4Uk4zQ3dU?=
 =?utf-8?B?V1F3V3JoTklLZXlSNDFLY3Z0TkhaSURobXJ4UnMxN1ExNnNkcVlnUThIMHFp?=
 =?utf-8?B?Wll5OS9kNmlKcGVZVUxYZSsyQzFBSFVwc2pvNUE3OXNkL3dLNjd2ZzdYNUZX?=
 =?utf-8?B?NzN5S3BtZW5xWEsweVptT3FUWVZDa1RZNTF0bUc4a0pBbDdZQ2pocmxoRHVO?=
 =?utf-8?B?UlZENVlSbG8xaUJpK1FTazV2NlVzWmk1V1JvUWtBMnY0Z01DWVUwcEhXZlIz?=
 =?utf-8?B?OHhlQ0w2MGxHZURQWnJUL1dlNGJRa293bFJoSEJMLzIzNXBNYXBYUW0yeldV?=
 =?utf-8?B?QzV3OGVJeUdOZDRFWkdJVmExaVBKdUhzSkhraStPTDM1bE5xbHpDZ1VvTm1T?=
 =?utf-8?B?UllEbHhlTSsxNVJuN0NXTHNKUCtHS0dnVlhQbE9nU3NvMkxmYlFJeGFOOVVh?=
 =?utf-8?B?eEt0Z3l6dWZpUDFFL0orWm44UFlQdkxDa3dZUXRjODIyRnFBb2lVZXNVQ1VX?=
 =?utf-8?B?M3o0M0xZeStZS0lXenNYNkRwR1pDbkh0UWMvWGRFVFNXNGlWSWwxRkFBRmdr?=
 =?utf-8?B?TzA2SjZlMFhFUmVTckdlaVFvWkgxNWtUVWFnenp5RXo4aHRwWER6RUkyR2cz?=
 =?utf-8?B?dGF4eGxtU2tRK3hlTndEdk9tc1BGSytpak5wTkRGT01PYlJaUmNVQWJBYjdz?=
 =?utf-8?B?SW1LakJmZmhvRUJwb0lpYkxaMktobkRKVmpLMExGUzVwUlJEUktPQm5rbVdw?=
 =?utf-8?B?RFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mYg1IG4bgm9ius/n7uBwE8iDVSEEQi6UIj5rvaDUdJ8v8YgQtomUuohmawkE5iWwXqgv5oIIm8K4VuTdkSntdtcEgOiGynXHtmu74pqN0y3Pvtl67OSdpq0aS9CiEWfClcyur4I5LwCMOexJbOxPMV4ux2bZ34L9By+jUFATxebSnvOjootNvGlBPytoEflr1vucvGdYcNSGC9dHJQbcUkdbvRZpVc4eRy4uQqmYjklsh7oOHs7xSFc4OC322o6RH5BXQIRlwPxR/6Tbp+ebhp6YyoGsqYcrn1e4iP8ahr7f9UpFpFh0Ms9UT8VyU6z0dts35sFwsGKcJZ9JZ6yaxvct1M3iArd36P7jdgsewm8EFj97SDSHKjJFVqUGHcP7RYPHR3ebAYZZzkwWXxIKovoQjggxjsUNivg+xBjqWDrCLH2ht7So97146tLiQb7aMXo44dehIgpZ6ZJFyMPvgnBXRyRgJGdxkyUCBe/LnL/giskfyWTCLq82e+kYuJ+PdnbLl1mlrijDJE9vPXSHHRoR3qyqx6JtGuPOiKKTkdCyD5CH6u0peGOqoNUeqj10Yy6Mp6lnaFjj05LMYxab5Mlr5H7NqBIbnbAfwZ6Oqjc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 104268f6-3669-44d2-1199-08dca0c68a4e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 09:56:16.6306 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nr4AJvmkUu8QlaYBbj4aLT9pnsXSuBhbCwRcfi9fybbuu40mwLkDGoRBAAKGd4KLXYpNp+Y0F1cHAOqxGHKVqAnNBnSo7jzAYETZ3QvTEq8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4899
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_06,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 adultscore=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407100067
X-Proofpoint-ORIG-GUID: H1ic_fTvD5Jb4MbKr9MtOdbHkXPTF7Qy
X-Proofpoint-GUID: H1ic_fTvD5Jb4MbKr9MtOdbHkXPTF7Qy
Received-SPF: pass client-ip=205.220.165.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0a-00069f02.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/07/2024 10:54, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Joao Martins <joao.m.martins@oracle.com>
>> Subject: Re: [PATCH v3 01/10] vfio/iommufd: Don't fail to realize on
>> IOMMU_GET_HW_INFO failure
>>
>> On 10/07/2024 03:53, Duan, Zhenzhong wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Joao Martins <joao.m.martins@oracle.com>
>>>> Subject: Re: [PATCH v3 01/10] vfio/iommufd: Don't fail to realize on
>>>> IOMMU_GET_HW_INFO failure
>>>>
>>>> On 09/07/2024 12:45, Joao Martins wrote:
>>>>> On 09/07/2024 09:56, Joao Martins wrote:
>>>>>> On 09/07/2024 04:43, Duan, Zhenzhong wrote:
>>>>>>> Hi Joao,
>>>>>>>
>>>>>>>> -----Original Message-----
>>>>>>>> From: Joao Martins <joao.m.martins@oracle.com>
>>>>>>>> Subject: [PATCH v3 01/10] vfio/iommufd: Don't fail to realize on
>>>>>>>> IOMMU_GET_HW_INFO failure
>>>>>>>>
>>>>>>>> mdevs aren't "physical" devices and when asking for backing
>> IOMMU
>>>> info, it
>>>>>>>> fails the entire provisioning of the guest. Fix that by filling caps info
>>>>>>>> when IOMMU_GET_HW_INFO succeeds plus discarding the error we
>>>> would
>>>>>>>> get into
>>>>>>>> iommufd_backend_get_device_info().
>>>>>>>>
>>>>>>>> Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>>>>>> Fixes: 930589520128 ("vfio/iommufd: Implement
>>>>>>>> HostIOMMUDeviceClass::realize() handler")
>>>>>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>>>>>> ---
>>>>>>>> hw/vfio/iommufd.c | 12 +++++-------
>>>>>>>> 1 file changed, 5 insertions(+), 7 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>>>>>>> index c2f158e60386..a4d23f488b01 100644
>>>>>>>> --- a/hw/vfio/iommufd.c
>>>>>>>> +++ b/hw/vfio/iommufd.c
>>>>>>>> @@ -631,15 +631,13 @@ static bool
>>>>>>>> hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void
>> *opaque,
>>>>>>>>
>>>>>>>>     hiod->agent = opaque;
>>>>>>>>
>>>>>>>> -    if (!iommufd_backend_get_device_info(vdev->iommufd, vdev-
>>>>> devid,
>>>>>>>> -                                         &type, &data, sizeof(data), errp)) {
>>>>>>>> -        return false;
>>>>>>>> +    if (iommufd_backend_get_device_info(vdev->iommufd, vdev-
>>>>> devid,
>>>>>>>> +                                         &type, &data, sizeof(data), NULL)) {
>>>>>>>
>>>>>>> This will make us miss the real error. What about bypassing host
>>>> IOMMU device
>>>>>>> creation for mdev as it's not "physical device", passing corresponding
>>>> host IOMMU
>>>>>>> device to vIOMMU make no sense.
>>>>>>
>>>>>> Yeap -- This was my second alternative.
>>>>>>
>>>>>> I can add an helper for vfio_is_mdev()) and just call
>>>>>> iommufd_backend_get_device_info() if !vfio_is_mdev().  I am
>> assuming
>>>> you meant
>>>>>> to skip the initialization of HostIOMMUDeviceCaps::caps as I think that
>>>>>> initializing hiod still makes sense as we are still using a
>>>>>> TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO somewhat?
>>>>>>
>>>>> Something like this is what I've done with this patch, see below. I think it
>>>>> matches what you suggested? Naturally there's a precedent patch that
>>>> introduces
>>>>> vfio_is_mdev().
>>>>>
>>>>
>>>> Sorry ignore the previous snip, it was the wrong version, see below
>> instead.
>>>>
>>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>>> index c2f158e60386..987dd9779f94 100644
>>>> --- a/hw/vfio/iommufd.c
>>>> +++ b/hw/vfio/iommufd.c
>>>> @@ -631,6 +631,10 @@ static bool
>>>> hiod_iommufd_vfio_realize(HostIOMMUDevice
>>>> *hiod, void *opaque,
>>>>
>>>>     hiod->agent = opaque;
>>>>
>>>> +    if (vfio_is_mdev(vdev)) {
>>>> +        return true;
>>>> +    }
>>>> +
>>>
>>> Not necessary to create a dummy object.
>>> What about bypassing object_new(ops->hiod_typename) in
>> vfio_attach_device()?
>>>
>> Not sure I am parsing this. What dummy object you refer to here if it's not
>> vbasedev::hiod that remains unused? Also in a suggestion by Cedric, and
>> pre-seeding vbasedev::hiod during attach_device()[0]. So I will sort of do that
>> already, but your comments means we are allocating a dummy object
>> anyways too?
> 
> Yes, with your snip change, it's allocated by object_new(ops->hiod_typename) but not realized 
> and never used else where.
> 
>>
>> Or are you perhaps suggesting something like:
>>
>> @@ -1552,17 +1552,20 @@ bool vfio_attach_device(char *name,
>> VFIODevice *vbasedev,
>>
>>     assert(ops);
>>
>>     if (!ops->attach_device(name, vbasedev, as, errp)) {
>>         return false;
>>     }
>>
>>     if (!vfio_mdev(vbasedev) &&
>> 	 !HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev,
>> errp)) {
>>
>> ?
> 
> I mean bypass host IOMMU device thoroughly for mdev, like:
> 

/me facepalm.

Makes sense!

I read your comment in my head as "What about by passing
object_new(ops->hiod_typename)", when it was 'bypassing' that you wrote.

> --- a/hw/vfio/common.c
> +++ b/hw/vfio/common.c
> @@ -1548,6 +1548,10 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,
>          return false;
>      }
> 
> +    if (vfio_is_mdev(vdev)) {
> +        return true;
> +    }
> +
>      hiod = HOST_IOMMU_DEVICE(object_new(ops->hiod_typename));
>      if (!HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp)) {
>          object_unref(hiod);
> 
> 
>>
>>
>> [0]
>> https://lore.kernel.org/qemu-devel/4e85db04-fbaa-4a6b-b133-
>> 59170c471e24@oracle.com/
> 


