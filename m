Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF61AC3DA45
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 09:31:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRTeR-0003Tq-O5; Wed, 10 Jul 2024 05:30:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sRTeQ-0003TJ-4a
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 05:30:14 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <joao.m.martins@oracle.com>)
 id 1sRTeN-0001Y1-Q6
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 05:30:13 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A7fWkb012133;
 Wed, 10 Jul 2024 09:30:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
 message-id:date:subject:to:cc:references:from:in-reply-to
 :content-type:content-transfer-encoding:mime-version; s=
 corp-2023-11-20; bh=8ArRQJ+DnqN9QoLmpOjRibWFQG6e1dAK4f4LZA/qme4=; b=
 ULJQfitrXacDZF5kuFZ0UaOhF5HkZ1hpecr4Bh3J41yGvltLc6VClF+og3AdJupE
 BkUslBYDDspxxJ3cnsbMVmlHoq8yhn7dOBt80uOPt097SM5yP4PIONpjLGaA23Bl
 rP/EqJ4Xn7dGwL9EDQXClC1kIofgGvWiqKL/Uo1k8+ULp7jLB0P/5jt6zjQLZNM3
 fdmU8Eh9bxYCt1TorXHWv/pyjgxDVWUctJY290ppRdemXeI9JqRS3auIhcu4Pj2H
 k9Qj5xMjoDXSoAOfFxny+RuXlm0GxKdilaKFWUJfVfUuF/USW90fuyrNUDgJgzIw
 u/OStl9IJB7Wwu/oPLYq/Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com
 (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 407emsx86b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Jul 2024 09:30:06 +0000 (GMT)
Received: from pps.filterd
 (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19)
 with ESMTP id 46A7hulf004521; Wed, 10 Jul 2024 09:30:04 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
 by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id
 407tvexn38-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 10 Jul 2024 09:30:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCScPGWmU8YW5OWVo+JOt4P6jnKWP1BIPvpoFT+sXBJ6GvXqoXHf8CHCRthdi+IbDpPlmwNQxg5kYMwue5/8+wfRDmWNGBZFlQWeGx5Q2lmXpQAfQpO6tmJxgKGYmOQ1Za8f2aq8BGRiFlfOSaJALYOi1qByci1aHXqrw9+l72qcPe+0cCC6ZFTH9CkvKl4ngiVgqwuCwhFV8c2r+I0XF8yGqZFXZ9zBInBEbzuKqWDFYhblrHv7KHhKcO5XwabjVrRB8zsSupD4E0rhIEFKfc5sbY3yZRXsypWGsKS3KvLsIys3p+UhESu2WgFG9aLK5EKO0VljNVtj9DHmZ60frA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ArRQJ+DnqN9QoLmpOjRibWFQG6e1dAK4f4LZA/qme4=;
 b=bN6dWB+LCRXEj/9pf10160r05pZ3yTlv5CPkwppCSdeJl2/GgFC4ArwwwIqHyPYPe6Ut9dPif6UTTCuNGjIZ7LGlne31XBbegBGnmFreavs1go27sVfVCNaaca0Qu2FDxk2qsCrm+R5XrQHlSXSv+lQXwucl7+x+eT8ZPdu/vU9N9yMD5fKl7A8FfoAPDYM79Ir/+JmjlLzpzBw45Z7dBv+euqstXtvuDApXo917I2ieFpXb972g+AYQ4bcvLwRSQVOBoioG8EQ2ScOs5lZOk3MlS5CPn29PvRdsnkOyeu5KQZods5N8B39MgRd9/+3Hio7gHCmJx6muylntc+Luzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ArRQJ+DnqN9QoLmpOjRibWFQG6e1dAK4f4LZA/qme4=;
 b=IyCFuTxdmc1OFXCsZ+phoLUSEUuGNDxl1i8ijCmZL4kpmL6sbNCMoM/nVoWf5q+7K1Y4w5ZIQMV+Tomlb5fdndlRKBHlkNcTaI5lOlES0u9TdohpObE0/MZ5Qqk1ChCuUU9EqISQ3u9FYRNubopw5hpGwHeviO6vhnyAc2KuI8g=
Received: from PH0PR10MB5893.namprd10.prod.outlook.com (2603:10b6:510:149::11)
 by DS7PR10MB5901.namprd10.prod.outlook.com (2603:10b6:8:87::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.36; Wed, 10 Jul 2024 09:30:02 +0000
Received: from PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53]) by PH0PR10MB5893.namprd10.prod.outlook.com
 ([fe80::79f1:d24f:94ea:2b53%6]) with mapi id 15.20.7741.033; Wed, 10 Jul 2024
 09:30:02 +0000
Message-ID: <97858274-3e67-4908-8119-a1ef9b6a092f@oracle.com>
Date: Wed, 10 Jul 2024 10:29:46 +0100
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
Content-Language: en-US
From: Joao Martins <joao.m.martins@oracle.com>
In-Reply-To: <SJ0PR11MB6744E07A01918228E5F4068792A42@SJ0PR11MB6744.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0026.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::13)
 To PH0PR10MB5893.namprd10.prod.outlook.com
 (2603:10b6:510:149::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5893:EE_|DS7PR10MB5901:EE_
X-MS-Office365-Filtering-Correlation-Id: 9013b18c-905f-4e6e-c7ea-08dca0c2dfdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?L0lWU09zUVRGck9PYzF0SXc0akJaUUR5NXRSVk14aVdXWGlFVk5hWHR4SHZ2?=
 =?utf-8?B?b3ZJODhiOVVjejYzMmNWQjJ2Ti8yU1ZXL1Jnd2p5ZDNBQVIvSVpCeERYZ2tk?=
 =?utf-8?B?b1ozazZySWtmdWh3azljQ0UxczZYWEJnb1RkUVo0d1N0Mis2WFZ6eHZQUEJm?=
 =?utf-8?B?U3UyVTZZYm1Gd1l4UkpKSEQ1NVJLQTgvM3hnQ21oWFRTTHh0anpvOHY0U0Ux?=
 =?utf-8?B?N1VpaWF1dlZseWxKcytjbHI3QVhoUnp6ZnBPbC9iOFFEVGlST0RXZHlYL2N3?=
 =?utf-8?B?TGVrWTVzOTAxWDlIc0VJQklVeGFLbGM1bVBuUWQyMXFGb0lNYmZlU05SWDVC?=
 =?utf-8?B?ZzhKaXVwbVBBOFdabzdLelNLSmNDS2RnYmt6U0Rqdzlwb25SNXJ4c2RXTUJk?=
 =?utf-8?B?OTZFOVoxR3cvVXlmeHV4N2VQelAwclJINHBVQm0ySTlrbDZHM0ZTUEc1M0FI?=
 =?utf-8?B?dm5PdlgrVUpDczdoa0swcG5haWRRZDc5QUVTbWQybHdya3pvWTExN0s2Rmth?=
 =?utf-8?B?NGFPZFVwSU5DdXQ0N0k1cm1lY25wekMxUjRzbnAwY1c4KzFoeTJJVVd5cFMy?=
 =?utf-8?B?bEs4WCs0Yys1Z2FkV2lPTDB1RTZUWHdvNC9KcUZUb1FtTWRyZmJtTnVHbWhS?=
 =?utf-8?B?YWNEcjlIM29jUW1DRHBYS1hPZWlPUjJqTjJ1dkVXbjdJTzlaalE0c0lyTngr?=
 =?utf-8?B?b3VIZkJWRVd5VmsyWFVDMTdKQUdjclA3SjhnK0JGRStsWU80VWNUcWVmTFNW?=
 =?utf-8?B?bFM0ZzQvY3J5ZitVV3lzOWszUUhueGg2WEViSFlzdktoNXRqYm9LdEhnU1Rz?=
 =?utf-8?B?cWtDTUNlaHRDOWpHVk1sbzg1dm5QMzRXNTlhUzBjaFpHMzZ6alRBQTY2OHZh?=
 =?utf-8?B?TVBBOTJVaDRWWUtULzRnTmNJckoyMVBXelRSajFWemJ3em1jSzZhWXBISjcw?=
 =?utf-8?B?UWF1bGc2K1hMUFNMZWlIdEtUOWZ3Q1hDVGhESHUzSmMrZTdBcUFOdDBPb2Ri?=
 =?utf-8?B?a01EZHZaYk8zbE9nVk9waXQ5NjJ1TjA5eERlNmY3RmRZU2VCSExubWN3MHlX?=
 =?utf-8?B?UGh5dEoxNGpTSUpRdGowN2g1dFQ4WFdTeHhPNlhidDJUL2tLNjM4eTRHSndo?=
 =?utf-8?B?OG9rQXZUY1FndFFneG5RUk0vbjNNQXZGa1pJZEl0ZlNaNi8yWHlzUHpYa01t?=
 =?utf-8?B?RHptT05saEYxazdBcUtoMUNNUlRjK1c0aEpMSm16NG9VQi9wUWdUcDV6SFdx?=
 =?utf-8?B?Sk5uV2JSTnFTNURxWDhzK21keUNyNndNYlVHU05xUk90cmZ4T0xnbWsvZ290?=
 =?utf-8?B?ZFQyaDB2QmZvM1FRM3JyeENoN1VTYUVXd0JWellBMElpcWN3bzlBRVl4bzAy?=
 =?utf-8?B?ZGZpZU45M3JNdGhNckcyRkwyckdjb3dSZ2NJTVRSM2IyemNuYktkNWJ5cC9V?=
 =?utf-8?B?WXFzbFZhcWVhNS9HNnZtNUluS1NqWFh1VWNYS3dWT2krcG5WREU0VFdSU282?=
 =?utf-8?B?NUF6K0NmeExLeFhTK3pQaTM5SXVPZTQvRWhWN3hjVlJHaHJZdGhjRkJxMHZU?=
 =?utf-8?B?aS9KcStOdEY1UWZmM2FwTlJaZFZBbHRZeWErQWZrbDVrdWVpaFRTYkNhYXdn?=
 =?utf-8?B?eGxQV08vcmh5N2tZWURmOTZHSEtpNmx2cmVOcTZmUEFrL0ltQzhkRTE3RXdk?=
 =?utf-8?B?QmJ4cXpGQVgrczZNM2svQWhyZ2ZTckp5VktmMVYwUzNLSnQxelFrYnBsN3Jm?=
 =?utf-8?Q?K9aYeoNR7DCYxwc4Wo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR10MB5893.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1hvSE1JTUNsNWdQa0xCN2Q2MFM2dVV0eDduNW50RmplL2lneXN4anpKdkMz?=
 =?utf-8?B?YkNVL055c2RuMDZ1OTE0eitqbnpLbWI3RWQweDI1c1BRQnJHajdPTjc3QTIz?=
 =?utf-8?B?NVlpS3BYODdDdXdFQXp2VXU1alVBdXI5QVFhNmt4MHBsNXNmZElRN00vOFk5?=
 =?utf-8?B?VW10cHBzNm9MK3VXZjhXc3U1TTRzK29NTFBoeTlxVFhUV3lzcWpkbm5WUGl5?=
 =?utf-8?B?UDZnYVlSZHNzb2Zhbi9yV0xGK3hvbW5VQU8vbWlvWWlFUm1obFhxWC8yb2FG?=
 =?utf-8?B?bWRWejlHd1FKNVllMk1xakx1RFcrRnNjemd1c0p0YVFUNnkrWjV5V3FPdFh1?=
 =?utf-8?B?OFdaY0M1eGdiK2pBSFc3UkdLeHhCZE8vTjd0TDIzemRGN0xBUnk1SFIxbmJa?=
 =?utf-8?B?dHB3aE5VRURWUGJ3YXVKUkVxbzE3REhOSWpOTE9ja2J2S3RtNDhsSFlWSXlF?=
 =?utf-8?B?L0FaQW12MnpvUWFBQjFIQUh5RnlHZzQ4RE4yNm1VWm55V3cwNTMrbnkzU0Jw?=
 =?utf-8?B?Y045Mkw3YTRpelA3c25nUDFiR2Q5MXFoRGkxUnBwMXdwbEs3dUlyeTF2aTl4?=
 =?utf-8?B?WHNQRVg4K3ZZNXhySlk2MzR2QzYwMUFrelp2eDhDL0MwM2FwSDRGUTFvUWUw?=
 =?utf-8?B?ZzhHQksvRk9JanJTQVBuZVFmK09KTU45RjlqUTA1WFpVNzkwUmczL1RQRXhD?=
 =?utf-8?B?VERpUTg5U3IyVnNQbE9QeWhBTjlSbGtKQnU4dEJkZTJXUnVaNHR0MEFDV2Ew?=
 =?utf-8?B?aXZYRWRGSjkxMGtuTnlCdnNPank1eVo3M1BaOC8wTE1BTEtkMEpCcXVGNkJy?=
 =?utf-8?B?YmVuaWhldE4yOC95ZmxyU2YrSCtBK200azZEZkJwZDNhR2hxT2F2QVJmRHhP?=
 =?utf-8?B?d25XcDI5ajdxeVRmRW5Ia2VnOHFMTmJJSGRSOExUbmJiVks1UlpiU0lKbGtR?=
 =?utf-8?B?QnJWT3NGQ29BR29rZ1lzZHFHSFRQT2pqUE5WNG5HRW1MYVlJbnVOTEl2SVox?=
 =?utf-8?B?T1BJRHJhanFMN2ZKRG5ITWFlU2pMSFJGdlhEQlJjS1JHRTRpL1BRdHY5eWhU?=
 =?utf-8?B?VngybUJRdTZCbkR1Yk92NHhpZ2hVdE1zMzVyU0hhRFBQRnNBN0lyRWNPMEsr?=
 =?utf-8?B?cEEwOWJvWjFCNHNIRlhMK005MzVrcURSZDl6L0VtMVROTHdXem1PcDE4L3RF?=
 =?utf-8?B?K0k3bDJyNmZjV0tSN0lPL1VVQitKMEppRVgvSk5ZTkg3U3g3UFAxVUJhdFZ5?=
 =?utf-8?B?cWFPb3ZHd1B0aWRWcnErMEQ3RkQyNGs2SjdmTW1oWUo5TlpDS1Q1dWpDSlVn?=
 =?utf-8?B?ZmJuaGtDTnpINzVsM05ieWdPV0N1RDBkdGg2L2RGOW1jSEJtSUdJOTZHSXdq?=
 =?utf-8?B?NlR1OWJWQ0lvWld3LzFjcHRsdnNZQWFDMlk2Y3U4a21WNm5LVEpPQ3lVSk9v?=
 =?utf-8?B?QmFNb1cwR3VmRklVK0tjZGl2SjZDd3d4VXhMbERSeGRJYStGUzlqZkJsTjhw?=
 =?utf-8?B?MGNPY0l3OXBRcnBLdnlvNmh2WTNXSmFUekNJVUtBeStIeEQweVZGN1cyVG9Y?=
 =?utf-8?B?ZnZrQjVadUVxY1FHVDliM2s3bW1vZ3A0Rm5xS0NRMFZHU3BjMVJDRDNVMTVy?=
 =?utf-8?B?aER3QU0yZWkxQXNJb0JVQVdSZWtUdGx5RWNnUnhGUVhzd2x0SS9NK0IydzE3?=
 =?utf-8?B?MDVDOHgvWjBaM0dzL01zbHlGdzVST1ZHTS9KcVFwZUg3WlBSS2xrRGdLWFVw?=
 =?utf-8?B?d3AzNU5RR3Zza2tZVGwvaFRWWERnTFd4SXZnQ25TS1hYZ3hPK2pvNTZheGNW?=
 =?utf-8?B?YmZxcWcwMmVXSXlSNHNOV0V1Sy9KQWpLTUw5TVZBMFZXaDN4blhCQzRaYWFY?=
 =?utf-8?B?R1FySjBEU0RrOEtvRnEzZ2N4YjMwTXdoQzU1TUxJcEJMZ1BKeitLa1NkRmxF?=
 =?utf-8?B?aVNuUDQzK21WQ0xHeDFLdUNlY3NYeEJybGs4ZXNJRy9tUDVqNGdkWFFoQUlU?=
 =?utf-8?B?aDN1d1JqL2tTeEJDanlERmlkYTV4MTBuZGVXeTFwNWNSd2pIU0VGdHhjZ2Jt?=
 =?utf-8?B?b2JXQUc4dm5sUGt5RkJvdDJ0U2Q2N29GVUEyQ0xad0VlUXdDa1FseUYxZzNZ?=
 =?utf-8?B?T3JtYmVsNWw4dEVyb2pQRkNKRGdYWmVIRGxqYVY3T2E3R0c2TmhWN2VBYThX?=
 =?utf-8?B?TEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hhhagsRoNXlSb3xroieKqt/TtcPWNwMXp5ut9ozdHQtD8aao0lweU1ussQfqxYvvHdAbWafT6nWUS3/KyeSOW+KXj7wj/MdForUNs4DMv2EYsKqf+jYcJJCCEjensjPXq+pm/MC+vgcV0uQ9kvKbXt3EjT5znH4flZuCXVHBlGbN2sYNv9ZWNiHkz+3v8D6eKkSnEajvWYK8ee4Um0+yTx5KAZ4swGq5uQ9c11yLsp30hl0MXNWlvgS2J8Z0xm7YtSV7bZ5ddMBA5KCXyldaBddU2Qqg161EyMMWXlZGZopkMnaHG4KoZ37jUwZIOCWxc7+ZcHO4IgzYWxecX3GEueuMIMuOE5lU2bvsNSMiTGE+6yQbkINb9JgO3UnTqFTg0b8PngB71gxayr7DPpB4SJTH2bL9gWbAy0rZtHPs/gyOgxQjD8efDyOW+phYvJ4dMRw0NaQMM9B5r3LJ3sjtU6M9IAMPxgFbjsEEWKFeSfzaRLcYJFaEna1oA6lpYwxaZ9fT5OjLC1hOKHcbeoK+pngdOCsKiFJv9tDGgNk5KMb6dM1Q+pajcWIhEpwA5sWvGQLZ9jJyiUt7Gf+UZfC3lQrEGmJBl7E85/BDCVTy9us=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9013b18c-905f-4e6e-c7ea-08dca0c2dfdb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5893.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 09:30:02.2109 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H77zC6XANCLK3rXVkzgM9GWZnUrBeyX9JEXO/Ajn6jasQRaFKk0rcfD53iLCGbyg/2vW4ZPL4ye8Xist5Br5L2++hgGXPoBAyJoDEiO7cm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5901
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_05,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 mlxscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407100064
X-Proofpoint-GUID: S-uLvsS_8crk6ikef7kXL1QJ1TNk5cLv
X-Proofpoint-ORIG-GUID: S-uLvsS_8crk6ikef7kXL1QJ1TNk5cLv
Received-SPF: pass client-ip=205.220.177.32;
 envelope-from=joao.m.martins@oracle.com; helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/07/2024 03:53, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Joao Martins <joao.m.martins@oracle.com>
>> Subject: Re: [PATCH v3 01/10] vfio/iommufd: Don't fail to realize on
>> IOMMU_GET_HW_INFO failure
>>
>> On 09/07/2024 12:45, Joao Martins wrote:
>>> On 09/07/2024 09:56, Joao Martins wrote:
>>>> On 09/07/2024 04:43, Duan, Zhenzhong wrote:
>>>>> Hi Joao,
>>>>>
>>>>>> -----Original Message-----
>>>>>> From: Joao Martins <joao.m.martins@oracle.com>
>>>>>> Subject: [PATCH v3 01/10] vfio/iommufd: Don't fail to realize on
>>>>>> IOMMU_GET_HW_INFO failure
>>>>>>
>>>>>> mdevs aren't "physical" devices and when asking for backing IOMMU
>> info, it
>>>>>> fails the entire provisioning of the guest. Fix that by filling caps info
>>>>>> when IOMMU_GET_HW_INFO succeeds plus discarding the error we
>> would
>>>>>> get into
>>>>>> iommufd_backend_get_device_info().
>>>>>>
>>>>>> Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>>>>> Fixes: 930589520128 ("vfio/iommufd: Implement
>>>>>> HostIOMMUDeviceClass::realize() handler")
>>>>>> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
>>>>>> ---
>>>>>> hw/vfio/iommufd.c | 12 +++++-------
>>>>>> 1 file changed, 5 insertions(+), 7 deletions(-)
>>>>>>
>>>>>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>>>>>> index c2f158e60386..a4d23f488b01 100644
>>>>>> --- a/hw/vfio/iommufd.c
>>>>>> +++ b/hw/vfio/iommufd.c
>>>>>> @@ -631,15 +631,13 @@ static bool
>>>>>> hiod_iommufd_vfio_realize(HostIOMMUDevice *hiod, void *opaque,
>>>>>>
>>>>>>     hiod->agent = opaque;
>>>>>>
>>>>>> -    if (!iommufd_backend_get_device_info(vdev->iommufd, vdev-
>>> devid,
>>>>>> -                                         &type, &data, sizeof(data), errp)) {
>>>>>> -        return false;
>>>>>> +    if (iommufd_backend_get_device_info(vdev->iommufd, vdev-
>>> devid,
>>>>>> +                                         &type, &data, sizeof(data), NULL)) {
>>>>>
>>>>> This will make us miss the real error. What about bypassing host
>> IOMMU device
>>>>> creation for mdev as it's not "physical device", passing corresponding
>> host IOMMU
>>>>> device to vIOMMU make no sense.
>>>>
>>>> Yeap -- This was my second alternative.
>>>>
>>>> I can add an helper for vfio_is_mdev()) and just call
>>>> iommufd_backend_get_device_info() if !vfio_is_mdev().  I am assuming
>> you meant
>>>> to skip the initialization of HostIOMMUDeviceCaps::caps as I think that
>>>> initializing hiod still makes sense as we are still using a
>>>> TYPE_HOST_IOMMU_DEVICE_IOMMUFD_VFIO somewhat?
>>>>
>>> Something like this is what I've done with this patch, see below. I think it
>>> matches what you suggested? Naturally there's a precedent patch that
>> introduces
>>> vfio_is_mdev().
>>>
>>
>> Sorry ignore the previous snip, it was the wrong version, see below instead.
>>
>> diff --git a/hw/vfio/iommufd.c b/hw/vfio/iommufd.c
>> index c2f158e60386..987dd9779f94 100644
>> --- a/hw/vfio/iommufd.c
>> +++ b/hw/vfio/iommufd.c
>> @@ -631,6 +631,10 @@ static bool
>> hiod_iommufd_vfio_realize(HostIOMMUDevice
>> *hiod, void *opaque,
>>
>>     hiod->agent = opaque;
>>
>> +    if (vfio_is_mdev(vdev)) {
>> +        return true;
>> +    }
>> +
> 
> Not necessary to create a dummy object.
> What about bypassing object_new(ops->hiod_typename) in vfio_attach_device()?
> 
Not sure I am parsing this. What dummy object you refer to here if it's not
vbasedev::hiod that remains unused? Also in a suggestion by Cedric, and
pre-seeding vbasedev::hiod during attach_device()[0]. So I will sort of do that
already, but your comments means we are allocating a dummy object anyways too?

Or are you perhaps suggesting something like:

@@ -1552,17 +1552,20 @@ bool vfio_attach_device(char *name, VFIODevice *vbasedev,

     assert(ops);

     if (!ops->attach_device(name, vbasedev, as, errp)) {
         return false;
     }

     if (!vfio_mdev(vbasedev) &&
	 !HOST_IOMMU_DEVICE_GET_CLASS(hiod)->realize(hiod, vbasedev, errp)) {

?


[0]
https://lore.kernel.org/qemu-devel/4e85db04-fbaa-4a6b-b133-59170c471e24@oracle.com/


